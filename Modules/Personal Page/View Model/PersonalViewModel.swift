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
                        self.user = UserInfo(name: data.response.firstName ?? "Ksenia", surname: data.response.lastName ?? "Petrova", patronymic: "", age: 19, nickname: data.response.username ?? "ksu", password: "", number: data.response.phone ?? "", mail: data.response.email ?? "", sex: "female", favorities: [], subscribes: [EventModel(id: 1, name: "reading.club", logo: Image("logoRead"), mainPhoto: Image("photoRead"), distination: "", price: "100", description: "Привет! Мы приглашаем тебе на посиделки в антикафе. Обсудим книги, поделимся впечатлениемя. И да, каждого ждёт сюрприз", participant: 5, like: false, data: "20.05.2022", contacts: "")], organiesed: [])
              
                    case .failure:
                        self.nicknameWarningText = "Bad internet connection"
                    }
                }
            }
        }
        user = UserInfo(name: "Ksenia", surname: "Petrova", patronymic: "", age: 19, nickname: "ksu", password: "", number: "", mail: "", sex: "female", favorities: [], subscribes: [EventModel(id: 1, name: "reading.club", logo: Image("logoRead"), mainPhoto: Image("photoRead"), distination: "", price: "100", description: "Привет! Мы приглашаем тебе на посиделки в антикафе. Обсудим книги, поделимся впечатлениемя. И да, каждого ждёт сюрприз", participant: 5, like: false, data: "20.05.2022", contacts: "")], organiesed: [])
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
        return user.image
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
  
}
