import Foundation
import SwiftUI
final class OrganizerViewModel: ObservableObject {
    @Published var user: UserInfo
    @Published var warningText: String = ""
    @Published var showWarning: Bool = false
    let service: Service
    var token: String
    
    init(service: Service, user: UserInfo, newUser: Bool) {
        self.service = service
        self.token = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        if newUser {
            self.user = user
        } else {
            self.user = UserInfo()
            getUserData()
        }
        
    }
    
    
    func getUserData() {
        DispatchQueue.main.async {
            self.service.getUsersData(token: self.token) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
            
                    self.user = UserInfo(name: data.response.firstName ?? "Ksenia", surname: data.response.lastName ?? "Petrova", patronymic: "", age: 19, nickname: data.response.username ?? "ksu", password: "", number: data.response.phone ?? "", mail: data.response.email ?? "", sex: "female", favorities: [], subscribes: [EventModel(id: 1, name: "reading.club", logo: Image("logoRead"), mainPhoto: Image("photoRead"), distination: "", price: "100", description: "Привет! Мы приглашаем тебе на посиделки в антикафе. Обсудим книги, поделимся впечатлениемя. И да, каждого ждёт сюрприз", participant: 5, like: false, data: "20.05.2022", contacts: "")], organiesed: [])
                case .failure:
                    self.warningText = "Ошибка"
                    self.showWarning = true
                    break
                    //self.nicknameWarningText = "Bad internet connection"
                }
            }
        }
    }
}
