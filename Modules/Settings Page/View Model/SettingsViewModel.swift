import Foundation
import SwiftUI
final class SettingsViewModel: ObservableObject {
    let service: Service
    @State var token: String
    var user: UserInfo
    init (service: Service, tok: String, user: UserInfo) {
        self.service = service
        token = tok
        self.user = user
    }
    
    
}

extension SettingsViewModel: SettingsViewProtocolOutput {
    
}
