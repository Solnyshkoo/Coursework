import Foundation
import SwiftUI
final class EventsViewModel: ObservableObject {
    @Published var user: UserInfo
    @Published var allEvents: [EventModel] = []
    var token: String
    let service: Service
    
    init(service: Service, user: UserInfo) {
        self.service = service
        self.token = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        self.user = user
        getEvents()

    }
    
    func getEvents() {
        DispatchQueue.main.async {
            
        }
    }
}
