import Foundation
import SwiftUI
final class OrganizerViewModel: ObservableObject {
   // private var user: UserInfo
    let service: Service
    var token = ""
    
    init(service: Service, token: String) {
        self.token = token
        self.service = service
    }
}
