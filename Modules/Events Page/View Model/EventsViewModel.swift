import Foundation
import SwiftUI
final class EventsViewModel: ObservableObject {
    @Published var user: UserInfo
    @Published var allEvents: [EventModel] = []
    var startIndex: Int = 0
    var totalAmount: Int = 0
    var token: String
    let service: Service
    
    init(service: Service, user: UserInfo) {
        self.service = service
        self.token = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        self.user = user
        getEvents()

    }
    
    func getEvents() {
        if totalAmount >= startIndex {
        DispatchQueue.main.async {
            self.service.getAllEvents(token: self.token, startIndex: self.startIndex) {  [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        
                    
                    for i in 0..<data.response.parties.count {
                        let index = self.allEvents.count
                        self.allEvents.append(self.createEvent(data: data.response.parties[i]))
                        self.getEventInfo(index: i, indexLast: index)
                    }
                    }
                case .failure(let error):
                    break
                }
            }
        }
        }
    }
//
    
    func getEventInfo(index: Int, indexLast: Int) {
        DispatchQueue.main.async {
            self.service.getEventPhoto(token: self.token, id: index) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.allEvents[indexLast].mainPhoto = Image(uiImage: data)
                        
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.allEvents[indexLast].mainPhoto = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                    }
                }
            }
            
            self.service.getUserPhoto(token: self.token, nick: self.allEvents[indexLast].creatorName) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.allEvents[indexLast].logo = Image(uiImage: data)
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.allEvents[indexLast].logo = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                    }
                }
            }
        }
    }
    
    private func createEvent(data: Party) -> EventModel {
        var item = EventModel()
        item.id = data.partyID
        item.contacts = data.endingAt
        item.price = String(data.price)
        item.distination = data.address
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        item.data = dateFormatter.date(from: data.startingAt) ?? Date()
        item.description = data.partyDescription
        item.name = data.name
        item.creatorName = data.creatorName
        item.participant = data.visitors.count
        return item
    }
    
}
