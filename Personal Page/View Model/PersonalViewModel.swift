import Foundation
import SwiftUI
final class PersonalViewModel: ObservableObject {
    var view: PersonalViewProtocolInput? {
        didSet {
            getUserData()
        }
    }
    let service: Service
    @State var token: String
    var user: UserInfo = UserInfo()
    
    init (service: Service, tok: String) {
        self.service = service
        token = tok
    }
    
    func getUserData() {
        user = UserInfo(name: "Ksenia", surname: "Petrova", patronymic: "lol", age: 20, nickname: "ksu09", password: "123", number: "12345", mail: "petr", sex: "female", image: Image("photo"), favorities: [], subscribes: [])
    }
}
extension PersonalViewModel: PersonalViewProtocolOutput {
    func setView(view: PersonalViewProtocolInput) {
        self.view = view
    }
    
    func getFio() -> String {
        return user.name + " " + user.surname
    }
    
    func getImage() -> Image {
        return user.image ?? Image(systemName: "circle")
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
}
