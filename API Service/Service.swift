
import Foundation
import SwiftUI
import UIKit
final class Service {
    private let adress = "https://0a37-2a00-1370-8182-3789-5ca6-8306-34d0-cb6f.ngrok.io"
    func validateUserData(respond: ValidateUserModel, _ closure: @escaping (Result<String, ValidationError>) -> Void) {
        guard let url = URL(string: "\(adress)/user/auth?username=\(respond.login)&password=\(respond.password)".encodeUrl) else {
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
            print("_____________2______________")
            print(post.response.accessToken)
            print("_____________2______________")
            result = .success(post.response.accessToken)
            closure(result)
        }
        session.resume()
    }
    
   
    
    func registrateUser(respond: UserInfo, _ closure: @escaping (Result<String, RegistrationUserError>) -> Void) {
        guard let url = URL(string: "\(adress)/user/create?first_name=\(respond.name)&last_name=\(respond.patronymic)&username=\(respond.nickname)&email=\(respond.mail)&password=\(respond.password)".encodeUrl) else {
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
}

extension String {
    var encodeUrl: String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }

    var decodeUrl: String {
        return self.removingPercentEncoding!
    }
}
struct Details: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
