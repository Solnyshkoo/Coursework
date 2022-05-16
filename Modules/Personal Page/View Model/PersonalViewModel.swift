import Foundation
import SwiftUI
final class PersonalViewModel: ObservableObject {
    var view: PersonalViewProtocolInput? {
        didSet {
            getData()
        }
    }

    let service: Service
    var warningText = "";
    var nicknameWarningText = "";
  //  @State var сanEdit: Bool = false
    @State var token: String
    @Published var user: UserInfo = .init()
    
    init(service: Service, tok: String) {
        self.service = service
        token = tok
    }
}

extension PersonalViewModel: PersonalViewProtocolOutput {
    func setView(view: PersonalViewProtocolInput) {
        self.view = view
    }
    
    func getFio() -> String {
        return user.name + " " + user.surname
    }
    
    func getData() {
        if  token != "" {
        service.getUsersData(token: token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                
                self.user = UserInfo(name: data.response.firstName ?? "Ksenia", surname: data.response.lastName ?? "Petrova", patronymic: "", age: 19, nickname: data.response.username ?? "ksu", password: "", number: data.response.phone ?? "", mail: data.response.email ?? "", sex: "female", favorities: [], subscribes: [EventModel(id: 1, name: "reading.club", logo: Image("logoRead"), mainPhoto: Image("photoRead"), distination: "", price: "100", description: "Привет! Мы приглашаем тебе на посиделки в антикафе. Обсудим книги, поделимся впечатлениемя. И да, каждого ждёт сюрприз", participant: 5, like: false, data: "20.05.2022", contacts: "")], organiesed: [])
                break
              
            case .failure(_):
                self.nicknameWarningText = "Bad internet connection"
                break
            }
        }
        }
        self.user = UserInfo(name: "Ksenia", surname: "Petrova", patronymic: "", age: 19, nickname: "ksu", password: "", number: "", mail: "", sex: "female", favorities: [], subscribes: [EventModel(id: 1, name: "reading.club", logo: Image("logoRead"), mainPhoto: Image("photoRead"), distination: "", price: "100", description: "Привет! Мы приглашаем тебе на посиделки в антикафе. Обсудим книги, поделимся впечатлениемя. И да, каждого ждёт сюрприз", participant: 5, like: false, data: "20.05.2022", contacts: "")], organiesed: [])
        
    }
    
    func changePhoto(image: Image) {
        user.image = image
    }
    
    func changeNickname(nick: String) {
        service.changeUserNickname(token: token, nick: nick) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.user.nickname = nick
                break
              
            case .failure(_):
                self.warningText = "Nickname is busy"
                break
            }
        }
        
    }
    
    func getImage() -> Image {
        return user.image
    }
  
    func getNickname() -> String {
        return "@" + user.nickname
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
