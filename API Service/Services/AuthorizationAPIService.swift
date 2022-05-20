import Foundation
import SwiftUI
import UIKit
final class AuthorizationAPIService {
    func validateUserData(respond: ValidateUserModel, _ closure: @escaping (Result<String, ValidationError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/user/auth?username=\(respond.login)&password=\(respond.password)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, _ in
            var result: Result<String, ValidationError>
            guard
                let data = data,
                let post = try? JSONDecoder().decode(Details.self, from: data)
            else {
                guard let response = response as? HTTPURLResponse else { return }
                
                if response.statusCode == 233 {
                    result = .failure(ValidationError.noUser)
                } else if response.statusCode == 234 {
                    result = .failure(ValidationError.wrongPassword)
                } else {
                    result = .failure(ValidationError.fatalEror)
                }
                closure(result)
                return
            }
            result = .success(post.response.accessToken)
            closure(result)
        }
        session.resume()
    }
    
    func registrateUser(respond: UserInfo, _ closure: @escaping (Result<String, RegistrationUserError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/user/create?first_name=\(respond.name)&last_name=\(respond.patronymic)&username=\(respond.nickname)&email=\(respond.mail)&password=\(respond.password)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, _ in
            var result: Result<String, RegistrationUserError>
            guard
                let data = data,
                let post = try? JSONSerialization.jsonObject(with: data, options: .json5Allowed) as? [String: Any],
                let token = post["access_token"] as? String
            else {
                guard let response = response as? HTTPURLResponse else { return }
                
                if response.statusCode == 233 {
                    result = .failure(RegistrationUserError.loginIsBusy)
                } else if response.statusCode == 234 {
                    result = .failure(RegistrationUserError.alreadyExists)
                } else {
                    result = .failure(RegistrationUserError.fatalEror)
                }
                closure(result)
                return
            }
            result = .success(token)
            closure(result)
        }
        session.resume()
    }
    
    
    
    func restoreUserPassword() {
        
    }
    
    func sendUserCodeToEmail() {
        
    }
    
    func checkEmailCode() {
        
    }
}
