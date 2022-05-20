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
    var codeRight: String = ""
    var mails: [String: String] = [:]
    var wrongMail = " "
    var failRestoreText = " "
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
                    DispatchQueue.main.async {
                        self.signUpFailed = " "
                        self.token = token
                        self.showHome = true
                        self.showSignUpAlert = false
                        UserDefaults.standard.set(token, forKey: "token")

                    }
                   
                case .failure(let error):
                    DispatchQueue.main.async {
                    self.showHome = false
                    self.signUpFailed = error.errorDescription!
                    self.showSignUpAlert = true
                    print(error.errorDescription!)
                    }
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
                self.service.getUserEmailByNickname(nickname: nickname) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let token):
                        DispatchQueue.main.async {
                            if token.trimmingCharacters(in: .whitespacesAndNewlines) == email {
                                self.mails[nickname] = token
                                self.emailUser = false
                                self.codeSend = true
                                self.showAllert = false
                                self.wrongMail = ""
                            } else {
                                self.emailUser = true
                                self.codeSend = false
                                self.showAllert = true
                                self.wrongMail = "Почта не соответсвует этому пользователю"
                            }
                        }
                       
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.emailUser = true
                            self.codeSend = false
                            self.showAllert = true
                            self.wrongMail = error.errorDescription ?? "Ошибка"
                        print(error.errorDescription!)
                        }
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
       
        DispatchQueue.main.async {
            self.service.sendUserCodeToEmail(email: email) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let token):
                    DispatchQueue.main.async {
                    self.codeSend = true
                    self.codeRight = token
                    self.showAllert = false
                    self.wrongMail = ""
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                    self.codeSend = false
                    self.codeRight = ""
                    self.showAllert = true
                    self.wrongMail = error.errorDescription ?? "Ошибка"
                    }
                }
            }
        }
    }
    
    func checkEmailCode(сode: String) {
        if self.codeRight == сode {
            wrongMail = ""
            wrongCode = false
            showPasswordView = true
        } else {
            wrongMail = "Неправильный код"
            wrongCode = true
            showPasswordView = false
        }
    }

    func getText() -> String {
        return signInFailed
    }
    
    func getToken() -> String {
        return token
    }
}
