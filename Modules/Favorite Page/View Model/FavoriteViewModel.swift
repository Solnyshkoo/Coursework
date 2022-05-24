import Foundation
import SwiftUI
final class FavoriteViewModel: ObservableObject {
    @Published var warning: Bool = false
    @Published var warningDelete: Bool = false
    @Published var events = [EventModel]()
    var token: String = UserDefaults.standard.object(forKey: "token") as? String ?? ""
    let service: Service
    
    init(service: Service) {
        self.service = service
        print("init - FavoriteViewModel")
    }

    func deleteFromFavorite(respond: Int) {
        DispatchQueue.main.async {
            self.service.deleteLike(token: self.token, index: respond) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success: // TODO: исправить
                    DispatchQueue.main.async {
                        self.warning = false
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.warning = true
                    }
                }
            }
        }
    }
    
    func addEventToFavorite(respond: Int) {
        DispatchQueue.main.async {
            self.service.setLike(token: self.token, index: respond) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success: // TODO: исправить
                    DispatchQueue.main.async {
                        self.warning = false
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.warning = true
                    }
                }
            }
        }
    }
    
    func getFavorites(user: UserInfo) {
        self.events = user.favorities
        for i in 0..<user.favorities.count {
            self.getEventInfo(index: user.favorities[i].id, i: i)
           
        }
    }
    
    func getEventInfo(index: Int, i: Int) {
        var item = EventModel()
        DispatchQueue.main.async {
            self.service.getEventInfo(eventId: index, token: self.token) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        item = self.createEvent(data: data)
                        self.events[i] = self.createEvent(data: data)
                    }
                case .failure:
                    break
                }
            }
            
            self.service.getEventPhoto(token: self.token, id: index) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.events[i].mainPhoto = Image(uiImage: data)
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.events[i].mainPhoto = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                    }
                }
            }
            
            self.service.getUserPhoto(token: self.token, nick: item.creatorName) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.events[i].logo = Image(uiImage: data)
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.events[i].logo = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                }
            }
        }
        }
    }
   
    private func createEvent(data: PartyData) -> EventModel {
        var item = EventModel()
        item.id = data.response.partyID
        item.contacts = data.response.endingAt
        item.price = String(data.response.price)
        item.distination = data.response.address
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        item.data = dateFormatter.date(from: data.response.startingAt) ?? Date()
        print(data.response.startingAt)
        print( item.data)
        print(Date())
        item.description = data.response.responseDescription
        item.name = data.response.name
        item.creatorName = data.response.creatorName
        item.participant = data.response.visitors.count
        return item
    }
}
