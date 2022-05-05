import Foundation
import SwiftUI

final class LogInViewModel: ObservableObject {
   // var view: MainViewProtocolInput?
    let service: Service
    
    @Published var warningText = " "
    private var token = ""
    init (service: Service) {
        self.service = service
    }
    
}

extension LogInViewModel: MainViewProtocolOutput {
    func setView(viewL: MainViewProtocolInput) {
        
    }
    
    
    func validateUser(respond: ValidateUserModel) -> Bool {
        DispatchQueue.main.async {
            self.service.validateUserData(respond: respond) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let token):
                    DispatchQueue.main.async {
                        self.warningText = " "
                    }
                    self.token = token
                    break
                case .failure(let error):
                   DispatchQueue.main.async {
                        self.warningText = error.errorDescription!
                    }
                    break
                }
           }
    }
        
        
        print("_____________5______________")
        print( self.token == "" ? false :  true)
        print("_____________5______________")
        return self.token == "" ? false :  true
    }
    
    func getText() -> String {
        print("____________________________")
        print(warningText)
        print("____________________________")
        return warningText
    }
    
    func showWarning() -> Bool {
      
        return warningText == "" ? false : true
        
    }
    
//    func setView(viewL: MainViewProtocolInput) {
//        self.view = viewL
//    }
    
    func getService() -> Service {
        return service
    }
    
    func getToken() -> String {
        return token
    }

}
extension LogInViewModel: MailConfirmationViewProtocolOutput {
}

extension LogInViewModel: PasswordViewProtocolOutput {
    func validateUser(respond: UserInfo) -> Bool {
        warningText = " "
        DispatchQueue.main.async {
            self.service.registrateUser(respond: respond) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let token):
                    self.warningText = " "
                    self.token = token
                    print("_____________1______________")
                    print(token)
                    print("_____________1______________")
                    break
                case .failure(let error):
                    self.warningText = error.errorDescription!
                    print(error.errorDescription!)
                    break
                }
            }
        }
        return token == "" ? false : true
    }
    
    func getWarning() -> String {
        print("____________________________")
        print(warningText)
        print("____________________________")
        return warningText
    }
    
    func getServicApi() -> Service {
        return service
    }
    
    func getTokenUser() -> String {
        return token
    }
    
}

