import Foundation
import SwiftUI

final class LogInViewModel: ObservableObject {
    let service: AuthorizationAPIService
    @Published var signInFailed = " "
    @Published var signUpFailed = " "
    @Published var showSignUpAlert: Bool = false
    @Published var showHome = false
    @Published var codeSend: Bool = false
    @Published var showAllert: Bool = false
    @Published var wrongCode: Bool = false
    @Published var showHomeView = false
    @Published var showPasswordView: Bool = false
    @Published var successRestore = false
    @Published var showRestoreAlert = false
    @Published var emailUser = true
    @Published var showCodeView = false
    var mails: [String: String] = [:]
    var wrongMail = " "
    var failRestoreText = " "
    private var token = ""
    
    init(service: AuthorizationAPIService) {
        self.service = service
    }
    
    func validateUser(respond: ValidateUserModel) {
//        let k = Service()
//        DispatchQueue.main.async {
//            k.uploadUserPhoto(photo: Image(systemName: "photo"), token: "8Z1wNyFW6OZJI1Ypp3HzQg") { [weak self] result in
//                guard let self = self else { return }
//                switch result {
//                case .success(let token):
//                    break;
//                case .failure(let error):
//                    break;
//                }
//            }
//        }
        
//        let k = Service()
//        DispatchQueue.main.async {
//            k.changeUser(token: "8Z1wNyFW6OZJI1Ypp3HzQg", nick: "") { [weak self] result in
//                guard let self = self else { return }
//                switch result {
//                case .success(let token):
//                    DispatchQueue.main.async {
//                    self.show = token
//                    }
//                    break;
//                case .failure(let error):
//                    break;
//                }
//            }
//        }
        
//
        
        signInFailed = " "
        DispatchQueue.main.async {
            self.service.validateUserData(respond: respond) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let token):
                    UserDefaults.standard.set(token, forKey: "token")
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
    
    func registrateUser(respond: UserInfo) {
        signUpFailed = " "
        DispatchQueue.main.async {
            self.service.registrateUser(respond: respond) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let token):
                    self.signUpFailed = " "
                    self.token = token
                    self.showHome = true
                    self.showSignUpAlert = false
                    UserDefaults.standard.set(token, forKey: "token")
                    print(token)
                case .failure(let error):
                    self.showHome = false
                    self.signUpFailed = error.errorDescription!
                    self.showSignUpAlert = true
                    print(error.errorDescription!)
                }
            }
        }
    }
    
    func verifyEmail(email: String, nickname: String) {
        if let m = mails[nickname] {
            if m.trimmingCharacters(in: .whitespacesAndNewlines) == email {
                self.emailUser = false
                self.showCodeView = true
            } else {
                self.emailUser = true
                self.showCodeView = false
            }
        } else {
            DispatchQueue.main.async {
                self.service.getUserInfoByNickname(nickname: nickname) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let token):
                        if token.trimmingCharacters(in: .whitespacesAndNewlines) == email {
                            self.mails[nickname] = token
                            self.emailUser = false
                            self.codeSend = true
                        } else {
                            self.emailUser = true
                            self.codeSend = false
                        }
                    case .failure(let error):
                        print(error.errorDescription!)
                    }
                }
            }
        }
    }
    
    func restorePassword(pass: String) {
        // TODO: вызов метода restoreUserPassword, если удачно то токен сохраняем
        successRestore = true
        showRestoreAlert = false
        failRestoreText = ""
        showHome = true
    }
    
    func sendCodeToEmail(email: String) {
        // TODO: вызов метода sendUserCodeToEmail
   //     codeSend = true
        showAllert = false
        wrongMail = "не то"
    }
    
    func checkEmailCode(сode: String) {
        // TODO: вызов метода checkEmailCode
        wrongMail = ""
        wrongCode = false
        showPasswordView = true
        wrongMail = "не то опять"
    }

    func getText() -> String {
        return signInFailed
    }
    
    func getToken() -> String {
        return token
    }
}
