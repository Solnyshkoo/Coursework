import Foundation
import SwiftUI
final class EditEventViewModel: ObservableObject {
    let service: Service
    var token: String
    @Published var user: UserInfo
    @Published var event: EventModel
    @Published var editableEvent: EventModel
    @Published var canSaveEvent: Bool = false
    @Published var photo: UIImage?
    @Published var showWarning: Bool = false
    @Published var saveAll: Bool = false
    @Published var textWarning: String = ""
    
    @Published var first: Bool = false
    @Published var second: Bool = false
    @Published var third: Bool = false
    @Published var fourth: Bool = false
    @Published var fivth: Bool = false
    @Published var six: Bool = false
    @Published var seven: Bool = false
    
    init(service: Service, user: UserInfo, eventInfo: EventModel ) {
        self.service = service
        self.token = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        self.user = user
        self.event = eventInfo
        self.editableEvent = eventInfo
        photo = UIImage(imageLiteralResourceName: "noImage") 
    }
    
    
    func saveEvent() {
        if editableEvent.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showWarning = true
            textWarning = "Пустое название меропрития"
        } else if editableEvent.contacts.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showWarning = true
            textWarning = "Нет контактов для обратной связи"
        } else if editableEvent.price.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showWarning = true
            textWarning = "Не указана цена"
        } else if editableEvent.distination.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showWarning = true
            textWarning = "Не указан адрес"
        } else if photo == UIImage(imageLiteralResourceName: "noImage") {
            showWarning = true
            textWarning = "Фотография не добавлена"
        } else {
            var respond = editableEvent
            respond.mainPhoto = Image(uiImage: photo ?? UIImage(imageLiteralResourceName: "noImage") )
            respond.logo = user.image ?? Image("noImage")
    
            
            if respond.mainPhoto != event.mainPhoto {
                self.service.uploadPartyPhoto()
                first = true
            } else {
                first = true
            }
                
            if respond.data != event.data && !showWarning {
                DispatchQueue.main.async {
                    self.service.changePartyDate(token: self.token, time: respond.data, id: respond.id) { [weak self] result in
                        guard let self = self else {return}
                        switch result {
                        case .success(let ans):
                            DispatchQueue.main.async {
                                self.second = true
                            }
                         
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.showWarning = true
                                self.textWarning = error.errorDescription!
                                self.second = false
                            }
                        
                            
                        }
                    }
                }
            } else {
                second = true
            }
                
            if respond.name != event.name && !showWarning{
                DispatchQueue.main.async {
                    self.service.changePartyName(token: self.token, name: respond.name, id: respond.id) { [weak self] result in
                        guard let self = self else {return}
                        switch result {
                        case .success(let ans):
                            DispatchQueue.main.async {
                                self.third = ans
                            }
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.showWarning = true
                                self.textWarning = error.errorDescription!
                                self.third = false
                            }
                  
                            
                        }
                    }
                }
            } else  {
                third = true
            }
            
            if respond.contacts != event.contacts  && !showWarning{
                DispatchQueue.main.async {
                    self.service.changePartyContacts(token: self.token, contacts: respond.contacts, id: respond.id) { [weak self] result in
                        guard let self = self else {return}
                        switch result {
                        case .success(let ans):
                            DispatchQueue.main.async {
                                self.fourth = ans
                            }
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.showWarning = true
                                self.textWarning = error.errorDescription!
                                self.fourth = false
                            }
                            
                            
                        }
                    }
                }
            } else {
                fourth = true
            }
            
            if respond.price != event.price && !showWarning {
                DispatchQueue.main.async {
                    self.service.changePartyPrice(token: self.token, price: Int(respond.price)!, id: respond.id) { [weak self] result in
                        guard let self = self else {return}
                        switch result {
                        case .success(let ans):
                            DispatchQueue.main.async {
                                self.fivth = ans
                            }
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.showWarning = true
                                self.textWarning = error.errorDescription!
                                self.fivth = false
                            }
                            
                            
                        }
                    }
                }
            } else {
                fivth = true
            }
            
            if respond.description != event.description && !showWarning {
                DispatchQueue.main.async {
                    self.service.changePartyDescription(token: self.token, description: respond.description, id: respond.id) { [weak self] result in
                        guard let self = self else {return}
                        switch result {
                        case .success(let ans):
                            DispatchQueue.main.async {
                                self.six = ans
                            }
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.showWarning = true
                                self.textWarning = error.errorDescription!
                                self.six = false
                            }
                            
                            
                        }
                    }
                }
            } else {
                six = true
            }
            
            if respond.distination != event.distination  && !showWarning {
                DispatchQueue.main.async {
                    self.service.changePartyAdress(token: self.token, adress: respond.distination, id: respond.id) { [weak self] result in
                        guard let self = self else {return}
                        switch result {
                        case .success(let ans):
                            DispatchQueue.main.async {
                                self.seven = ans
                            }
                        case .failure(let error):
                            DispatchQueue.main.async {
                                self.showWarning = true
                                self.textWarning = error.errorDescription!
                                self.seven = false
                            }
                            
                            
                        }
                    }
                }
            } else {
                seven = true
            }
            
        }
    }
    
    
    func cancelChanges() {
        editableEvent = event
    }
    
}
