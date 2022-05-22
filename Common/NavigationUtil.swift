import UIKit
import Foundation

class NavigationUtil: ObservableObject {
    @Published var isAuth: Bool = false
       
    init() {
        let token = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        if token  == "" {
            isAuth = false
        } else {
            isAuth = true
        }
    }
       func logOut() {
           isAuth = false
           UserDefaults.standard.set("", forKey: "token")
       }
    
}
