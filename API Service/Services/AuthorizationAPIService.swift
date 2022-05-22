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
                print(response)
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
            result = .success(post.response.accessToken) // TODO: что происходит?
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
                let post = try? JSONDecoder().decode(Details.self, from: data)
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
            result = .success(post.response.accessToken)
            closure(result)
        }
        session.resume()
    }
    
    func getUserEmailByNickname(nickname: String, _ closure: @escaping (Result<String, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/get_mail?username=\(nickname)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, _ in
            var result: Result<String, InternetError>
            guard
                let data = data,
                let post =  try? JSONDecoder().decode(EmailResponse.self, from: data)
            else {
                guard let response = response as? HTTPURLResponse else { return }
                print(response)
                if response.statusCode == 404 {
                    result = .failure(InternetError.internetError)
                } else {
                    result = .failure(InternetError.fromServerError)
                }
                closure(result)
                return
            }
            print(post)
            result = .success(post.response.email)
            closure(result)
        }
        session.resume()
    }
    
    func restoreUserPassword() {}
    
    func sendUserCodeToEmail(email: String, _ closure: @escaping (Result<String, SendCodeError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/send_mail?mail=\(email)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, _, _ in
            var result: Result<String, SendCodeError>
            guard
                let data = data,
                let post = try? JSONDecoder().decode(CodeData.self, from: data)
            else {
                result = .failure(SendCodeError.internetError)
                closure(result)
                return
            }
            if post.response.code == -1 {
                result = .failure(SendCodeError.wrongMail)
            } else {
                result = .success(String(post.response.code))
            }
            closure(result)
        }
    
        session.resume()
    }

    func checkEmailCode() {}
}

struct CodeData: Codable {
    let response: ResponseCodeData
}

// MARK: - Response
struct ResponseCodeData: Codable {
    let code: Int
}
