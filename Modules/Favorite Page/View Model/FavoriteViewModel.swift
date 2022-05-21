import Foundation
import SwiftUI
final class FavoriteViewModel: ObservableObject {
    @Published var user: UserInfo
    var token: String
    let service: Service
    
    init(service: Service, user: UserInfo, newUser: Bool) {
        self.service = service
        self.token = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        if newUser {
            self.user = user
        } else {
            self.user = user
        }
        print("___________67__________")
        print(user)
        print("___________67__________")
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
                        for i in 0..<self.user.favorities.count {
                            self.getEventInfo(index: self.user.favorities[i].id, i: i)
                        }
                    }
                       
                case .failure:
                    break;
                }
            }
             }
        }
    }
    
    func getEventInfo(index: Int, i: Int) {
        DispatchQueue.main.async {
            self.service.getEventInfo(eventId: index, token: self.token) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                  
                            self.user.favorities[i] = self.createEvent(data: data)
                        
                    }
                case .failure:
                    break
                }
            }
            
            self.service.getEventPhoto(token: self.token, id: index) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        
                            self.user.favorities[i].mainPhoto = Image(uiImage: data)
                        
                    }
                case .failure:
                    DispatchQueue.main.async {
               
                            self.user.favorities[i].mainPhoto = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                        
                    }
                }
            }
            
            self.service.getUserPhoto(token: self.token, nick: self.user.subscribes[i].creatorName) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                       
                            self.user.favorities[i].logo = Image(uiImage: data)
                        
                    }
                case .failure:
                    DispatchQueue.main.async {
                     
                            self.user.favorities[i].logo = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                       
                    }
                }
            }
        }
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
