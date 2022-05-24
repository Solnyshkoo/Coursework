import Foundation
import SwiftUI
final class EventDetailViewModel: ObservableObject {
    @Published var info: EventModel = EventModel()
    @Published var warning: Bool = false
    @Published var warningDelete: Bool = false
    @Published var warningGoing: Bool = false
    @Published var warningGoingDelete: Bool = false
    @Published var review: Bool = false
    @Published var warningReviewDelete: Bool = false
    @Published var reviewDelete: Bool = false
    @Published var warningReview: Bool = false
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
        item.visitors = data.response.visitors
        for i in 0..<data.response.comments.count {
            var r = ReviewModel()
            r.review = data.response.comments[i].text
            r.id = data.response.comments[i].reviewID
            r.nickname = data.response.comments[i].author.username
            item.comments.append(r)
        }
        return item
    }
    
    func deleteFromFavorite(respond: Int) {
        DispatchQueue.main.async {
            self.service.setLike(token: self.token, index: respond) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success: 
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
                case .success:
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
    
    
    
    func deleteFromGoingTo(respond: Int) {
        DispatchQueue.main.async {
            self.service.deleteGoingTo(token: self.token, index: respond) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        
                        self.warningGoing = false
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.warningGoing = true
                    }
                }
            }
        }

    }
    
    func addEventToGoingTo(respond: Int) {
        DispatchQueue.main.async {
            self.service.setGoingTo(token: self.token, index: respond) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self.warningGoingDelete = false
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.warningGoingDelete = true
                    }
                }
            }
        }
    }

    func addReview(text: String) {
        DispatchQueue.main.async {
            self.service.addReview(token: self.token, partyId: self.partyId, text: text) {  [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self.warningReview = false
                        self.review = true
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.warningReview = true
                        self.review = false
                    }
                }
            }
        }
    }
    
    func deleteReview(id: Int) {
        DispatchQueue.main.async {
            self.service.deleteReview(token: self.token, reviewId: id) {  [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self.reviewDelete = true
                        self.warningReviewDelete = false
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.reviewDelete = true
                        self.warningReviewDelete = true
                    }
                }
            }
        }
    }
}
