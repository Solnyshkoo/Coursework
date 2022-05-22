import Foundation
import SwiftUI
final class PersonalViewModel: ObservableObject {
    var view: PersonalViewProtocolInput?

    @Published var warningText = ""
    @Published var warning = false
    var nicknameWarningText = ""
   
    @Published var user: UserInfo
    @Published var userpresent: Bool = false
    @Published var events: [Int: EventModel] = [:]
    var token: String
    let service: Service
    
    init(service: Service, user: UserInfo) {
        self.service = service
        self.token = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        self.user = user

    }
    
    func setView(view: PersonalViewProtocolInput) {
        self.view = view
    }
    
    func getFio() -> String {
        return user.name + " " + user.surname
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

    func setPicture(image: Image) {
        user.image = image
    }
}
