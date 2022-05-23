import Foundation
import SwiftUI
final class EventDetailViewModel: ObservableObject {
    @Published var info: EventModel = EventModel()
    var token: String
    let service: Service
    var partyId: Int
    
    
    init(service: Service, id: Int) {
        self.service = service
        self.token = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        self.partyId = id
        getEventInfo()
        if info.passed {
            for i in 0..<info.comments.count {
                getUserPhoto(index: i)
            }
        }
    }
    
    func getEventInfo() {
        DispatchQueue.main.async {
            self.service.getEventInfo(eventId: self.partyId, token: self.token) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.info = self.createEvent(data: data)
                    }
                case .failure:
                    break
                }
            }
            
            self.service.getEventPhoto(token: self.token, id: self.partyId) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.info.mainPhoto = Image(uiImage: data)
                      
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.info.mainPhoto = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                    }
                }
            }
            
            self.service.getUserPhoto(token: self.token, nick: self.info.creatorName) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.info.logo = Image(uiImage: data)
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.info.logo = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                      
                    }
                }
            }
        }
    }
    
    
    func getUserPhoto(index: Int) {
        self.service.getUserPhoto(token: self.token, nick: self.info.comments[index].nickname) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.info.comments[index].logo = Image(uiImage: data)
                }
            case .failure:
                DispatchQueue.main.async {
                    self.info.comments[index].logo = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
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
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        item.data = dateFormatter.date(from: data.response.startingAt) ?? Date()
        item.description = data.response.responseDescription
        item.name = data.response.name
        item.creatorName = data.response.creatorName
        item.participant = data.response.visitors.count
        for i in 0..<data.response.comments.count {
            var r = ReviewModel()
            r.review = data.response.comments[i].text
            r.id = data.response.comments[i].reviewID
            r.nickname = data.response.comments[i].author.username
            item.comments.append(r)
        }
        return item
    }
    
    
    func getComments() {
        
    }
}
