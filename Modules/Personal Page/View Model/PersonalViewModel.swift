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
    @Published var userpresent: Bool = false
    @Published var events: [Int: EventModel] = [:]
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
                case .success(let data): // TODO: исправить
                    DispatchQueue.main.async {
                        self.user = self.createUser(data: data)
                        for i in 0..<self.user.subscribes.count {
                            self.getEventInfo(index: self.user.subscribes[i].id, i: i, array: 1)
                        }
                        for i in 0..<self.user.organiesed.count {
                            self.getEventInfo(index: self.user.organiesed[i].id, i: i,  array: 2)
                        }
                    }
                       
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
                DispatchQueue.main.async {
                    self.user.nickname = nick
                    self.view?.save()
                }
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
    
    func getEventInfo(index: Int, i: Int, array: Int) {
        DispatchQueue.main.async {
            self.service.getEventInfo(eventId: index, token: self.token) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        if array == 1 {
                            self.user.subscribes[i] = self.createEvent(data: data)
                        } else {
                            self.user.organiesed[i] = self.createEvent(data: data)
                        }
                    }
                case .failure:
                    break
                }
            }
            
            self.service.getEventPhoto(token: self.token, id: index) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        if array == 1 {
                            self.user.subscribes[i].mainPhoto = Image(uiImage: data)
                        } else {
                            self.user.organiesed[i].mainPhoto = Image(uiImage: data)
                        }
                    }
                case .failure:
                    DispatchQueue.main.async {
                        if array == 1 {
                            self.user.subscribes[i].mainPhoto = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                        } else {
                            self.user.organiesed[i].mainPhoto = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                        }
                    }
                }
            }
            
            self.service.getUserPhoto(token: self.token, nick: self.user.subscribes[i].creatorName) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        if array == 1 {
                            self.user.subscribes[i].logo = Image(uiImage: data)
                        } else {
                            self.user.organiesed[i].logo = Image(uiImage: data)
                        }
                    }
                case .failure:
                    DispatchQueue.main.async {
                        if array == 1 {
                            self.user.subscribes[i].logo = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                        } else {
                            self.user.organiesed[i].logo = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                        }
                    }
                }
            }
        }
    }

    func setPicture(image: Image) {
        user.image = image
    }
  
    private func createUser(data: UserData) -> UserInfo {
        var array = data.response.favorites
        var fav: [EventModel] = []
        for i in 0..<array.count {
            if let index = Int(array[i]) {
                fav.append(EventModel(id: index))
            }
        }
        let array2 = data.response.partiesCreated
        var org: [EventModel] = []
        print("_____d_")
        
        print("_____d_")
        for i in 0..<array2.count {
            org.append(EventModel(id: array2[i]))
        }
            
        array = data.response.goingTo
        var sub: [EventModel] = []
        for i in 0..<array.count {
            if let index = Int(array[i]) {
                sub.append(EventModel(id: index))
            }
        }
    
        return UserInfo(name: data.response.user.firstName, surname: data.response.user.lastName, patronymic: "", age: -1, nickname: data.response.user.username, password: "", number: "", mail: data.response.user.email, sex: "", image: nil, validate: false, favorities: fav, subscribes: sub, organiesed: org)
    }
    
    private func createEvent(data: PartyData) -> EventModel {
        var item = EventModel()
        item.id = data.response.partyID
        item.contacts = data.response.endingAt
        item.price = String(data.response.price)
        item.distination = data.response.address
        item.data = data.response.startingAt
        item.description = data.response.responseDescription
        item.name = data.response.name
        item.creatorName = data.response.creatorName
        item.participant = data.response.visitors.count
        return item
    }
}
