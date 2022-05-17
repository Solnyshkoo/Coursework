import Foundation
import SwiftUI
import UIKit
final class Service {
    static let adress = "https://f971-2a00-1370-8182-3789-78fb-f648-a949-9dc1.ngrok.io"
    func getUsersData(token: String, _ closure: @escaping (Result<UserData, Error>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/user/get_info?access_token=\(token)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            var result: Result<UserData, Error>
            guard
                let data = data,
                let post = try? JSONDecoder().decode(UserData.self, from: data)
        
            else {
                result = .failure(error as! Error) //TODO мб nill
                closure(result)
                return
            }
            result = .success(post)
            closure(result)
        }
        session.resume()
    }
    
    func changeUserNickname(token: String, nick: String, _ closure: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/user/change/username?username=\(nick)&access_token=\(token)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            var result: Result<Bool, Error>
            guard
                let data = data,
                let post = try? JSONSerialization.jsonObject(with: data, options: .json5Allowed) as? [String: Any],
                let token = post["response"] as? [String: Any],
                let token = token["username"] as? String
            else {
                result = .failure(error!)
                closure(result)
                return
            }
            result = .success(true)
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
