import Foundation
import SwiftUI
final class PersonalViewModel: ObservableObject {
    var view: PersonalViewProtocolInput? {
        didSet {
            getData()
        }
    }

    
    @Published var warningText = ""
    @Published var warning = false
    var nicknameWarningText = ""
   
    @Published var user: UserInfo
    var token: String
    let service: Service
    
    init(service: Service, user: UserInfo, newUser: Bool) {
        self.service = service
        self.token = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        if newUser {
            self.user = user
        } else {
            self.user = UserInfo()
            getData()
        }
    }
    
    func setView(view: PersonalViewProtocolInput) {
        self.view = view
    }
    
    func getFio() -> String {
        return user.name + " " + user.surname
    }
    
    func getData() {
        if token != "" {
            DispatchQueue.main.async {
                self.service.getUsersData(token: self.token) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let data): //TODO: исправить
                        self.user = self.createUser(data: data)
              
                    case .failure:
                        self.nicknameWarningText = "Bad internet connection"
                    }
                }
            }
        }
    }
    
    func changePhoto(image: Image) {
        user.image = image
    }
    
    func changeNickname(nick: String) {
        service.changeUserNickname(token: token, nick: nick) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.user.nickname = nick
                self.view?.save()
              
            case .failure:
                DispatchQueue.main.async {
                    self.warningText = "Nickname is busy"
                    self.warning = true
                }
            }
        }
    }
    
    func getImage() -> Image {
        return user.image ?? Image("noImage").resizable()
    }
  
    func getNickname() -> String {
        return user.nickname
    }
    
    func getMyEvents() -> [EventModel] {
        return user.organiesed
    }
    
    func getHistory() -> [EventModel] {
        return user.subscribes
    }
    
    func setPicture(image: Image) {
        user.image = image
    }
  
    private func createUser(data: UserData) -> UserInfo {
        var array = data.response.favorites
        var fav: [EventModel] = []
        for i in 0..<array.capacity {
            fav.append(EventModel(id: array[i]))
        }
        array = data.response.partiesCreated
        var org:[EventModel] = []
        for i in 0..<array.capacity {
            org.append(EventModel(id: array[i]))
        }
        array = data.response.goingTo
        var sub:[EventModel] = []
        for i in 0..<array.capacity {
            sub.append(EventModel(id: array[i]))
        }
    
        return UserInfo(name:  data.response.user.firstName , surname: data.response.user.lastName , patronymic: "", age: -1, nickname: data.response.user.username , password: "", number: "", mail: data.response.user.email , sex: "", image: nil, validate: false, favorities: fav, subscribes: sub, organiesed: org)
    }
}
