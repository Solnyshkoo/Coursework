import Foundation
import SwiftUI
final class NewEventViewModel: ObservableObject {
    @Published var user: UserInfo
    @Published var canCreateEvent: Bool = false
    @Published var showWarning: Bool = false
    @Published var textWarning: String = ""
    let service: Service
    var token: String
    
    init(service: Service, user: UserInfo) {
        self.service = service
        self.token = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        self.user = user
    }
    
    func createEvent(data: EventModel) {
        if data.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showWarning = true
            textWarning = "Пустое название меропрития"
        } else if data.contacts.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showWarning = true
            textWarning = "Нет контактов для обратной связи"
        } else if data.price.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showWarning = true
            textWarning = "Не указана цена"
        } else if !data.price.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            guard Int(data.price) != nil else {
                showWarning = true
                textWarning = "Цена должна быть целым числом"
                return
            }
        } else if data.distination.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showWarning = true
            textWarning = "Не указан адрес"
        } else if data.mainPhoto == Image(uiImage:UIImage(imageLiteralResourceName: "noImage")) {
            showWarning = true
            textWarning = "Фотография не добавлена"
        } else {
            var respond = data
            respond.logo = user.image ?? Image("noImage")
            
            DispatchQueue.main.async {
                self.service.createEvent(respond: respond, token: self.token) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let data):
                        respond.id = data
                        self.user.organiesed.append(respond)
                        self.showWarning = false
                   //     self.canCreateEvent = true
                        break
                    case .failure:
                        self.showWarning = true
                        self.textWarning = "К сожалению, мы не смогли сохранить мероприятие("
                      //  self.canCreateEvent = false
                        break
                    }
                }
                
                self.service.uploadPartyPhoto(photo: respond.mainPhoto, token: self.token, id: respond.id) { [weak self] result in
                    guard let self = self else {return}
                    switch result {
                    case .success(let ans):
                        DispatchQueue.main.async {
                            self.canCreateEvent = true
                        }
                     
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.showWarning = true
                            self.textWarning = "К сожалению, мы не смогли сохранить мероприятие("
                            self.canCreateEvent = false
                        }
                    }
                }
            }
        }
    }
}
