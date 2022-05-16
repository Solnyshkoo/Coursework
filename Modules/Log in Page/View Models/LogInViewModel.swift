import Foundation
import SwiftUI

final class LogInViewModel: ObservableObject {
    let service: AuthorizationAPIService
    @Published var signInFailed = " "
    @Published var codeSend: Bool = false
    @Published var wrongCode: Bool = false
    @Published var showHomeView = false;
    var wrongMail = " "
    private var token = ""
    
    init(service: AuthorizationAPIService) {
        self.service = service
    }
    
    func validateUser(respond: ValidateUserModel) {
        signInFailed = " "
        DispatchQueue.main.async {
            self.service.validateUserData(respond: respond) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let token):
                    DispatchQueue.main.async {
                        self.signInFailed = " "
                        self.showHomeView = true
                    }
                    self.token = token
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.signInFailed = error.errorDescription!
                    }
                }
            }
        }
    }
    
    func registrateUser(respond: UserInfo) -> Bool {
        signInFailed = " "
        DispatchQueue.main.async {
            self.service.registrateUser(respond: respond) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let token):
                    self.signInFailed = " "
                    self.token = token
                    print(token)
                case .failure(let error):
                    self.signInFailed = error.errorDescription!
                    print(error.errorDescription!)
                }
            }
        }
        return token == "" ? false : true
    }
    // TODO: - cделать метод
    func sendCodeToEmail() { //email: String
        codeSend = true;
        wrongMail = "не то"
    }
    
    func checkEmailCode() { //сode: String
        wrongMail = ""
        wrongCode = false
        wrongMail = "не то опять"
        // TODO: - cделать метод
    }

    
    func getText() -> String {
        return signInFailed
    }
    
    
    func getToken() -> String {
        return token
    }

}
