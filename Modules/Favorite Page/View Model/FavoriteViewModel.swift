import Foundation
import SwiftUI
final class FavoriteViewModel: ObservableObject {
   // @Published var user: UserInfo
    @Published var warning: Bool = false
    @Published var warningDelete: Bool = false
    var token: String = UserDefaults.standard.object(forKey: "token") as? String ?? ""
    let service: Service
    
    init(service: Service) {
        self.service = service
        
       // self.user = user
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
   
}
