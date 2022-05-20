import Foundation
import SwiftUI
final class VerificationViewModel: ObservableObject {
    @Published var user: UserInfo
    @Published var dataIsCorrect: Bool = false
    @Published var showWarning: Bool = false
    @Published var textWarning: String = ""
    let service: Service
    var token: String
    
    init(service: Service, user: UserInfo) {
        self.service = service
        self.token = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        self.user = user
    }
    
    
    func checkPassport(data: VerificationModel) {
        service.verificationPassport(respond: data)
        dataIsCorrect = true
        showWarning = false
        textWarning = ""
    }
}
