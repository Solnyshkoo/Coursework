import Foundation
import SwiftUI
import UIKit
final class Service {
    static let adress = "https://7ec0-109-252-174-120.ngrok.io"
    
    func getUsersData(token: String, _ closure: @escaping (Result<UserData, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/user/get_info?access_token=\(token)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            var result: Result<UserData, InternetError>
            guard
                let data = data,
                let post = try? JSONDecoder().decode(UserData.self, from: data)
            else {
                guard let response = response as? HTTPURLResponse else { return }
                if response.statusCode == 404 {
                    result = .failure(InternetError.internetError)
                } else {
                    result = .failure(InternetError.fromServerError)
                }
                closure(result)
                return
            }
            result = .success(post)
            closure(result)
        }
        session.resume()
    }
    
    func changeUserNickname(token: String, nick: String, _ closure: @escaping (Result<Bool, ChangeUserDataError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/user/change/username?username=\(nick)&access_token=\(token)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            var result: Result<Bool, ChangeUserDataError>
            guard
                let data = data,
                let _ = try? JSONSerialization.jsonObject(with: data, options: .json5Allowed) as? [String: Any]
            else {
                guard let response = response as? HTTPURLResponse else { return }
                print(response.statusCode)
                if response.statusCode == 233 {
                    result = .failure(ChangeUserDataError.busy)
                } else {
                    result = .failure(ChangeUserDataError.fatalEror)
                }
                print(response.statusCode)
                closure(result)
                return
            }
            result = .success(true)
            closure(result)
        }
        session.resume()
    }
    
    
    func getUserPhoto(token: String, nick: String, _ closure: @escaping (Result<UIImage, ChangeUserDataError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/user/get_photo?access_token=\(token)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            var result: Result<UIImage, ChangeUserDataError>
            guard
                let data = data,
                let image = UIImage(data: data)
            else {
                guard let response = response as? HTTPURLResponse else { return }
                print(response.statusCode)
                if response.statusCode == 233 {
                    result = .failure(ChangeUserDataError.busy)
                } else {
                    result = .failure(ChangeUserDataError.fatalEror)
                }
                print(response.statusCode)
                closure(result)
                return
            }
            let t = image
           
            result = .success(t)
            closure(result)
        }
        session.resume()
    }
    
    func uploadUserPhoto(photo: Image , token: String,  _ closure: @escaping (Result<Bool, Error>) -> Void) {
        let image : UIImage = photo.asUIImage()
        guard let url = URL(string: "\(Service.adress)/user/upload_photo?access_token=\(token)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let boundary = UUID().uuidString
        let session = URLSession.shared
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        var data = Data()
        data.append(image.pngData()!)
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
          
                    print(jsonData)
                
            } else {
                print(error)
                print(responseData)
                print(response)
            }
            print(error)
            print(responseData)
            print(response)
        }).resume()
    }
    
    
    
    
    func createEvent(respond: EventModel, token: String, _ closure: @escaping (Result<Int, InternetError>) -> Void)  {
        guard let url = URL(string: "\(Service.adress)/party/create?access_token=\(token)&name=\(respond.name)&description=\(respond.description)&address=\(respond.distination)&price=\(respond.price)&starting_at=\(respond.data)&ending_at=\(respond.contacts)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            var result: Result<Int, InternetError>
            guard
                let data = data,
                let post = try? JSONSerialization.jsonObject(with: data, options: .json5Allowed) as? [String: Any],
                let id = post["example_party_id"] as? Int
            else {
                guard let response = response as? HTTPURLResponse else { return }
                print(response.statusCode)
                if response.statusCode == 233 {
                    result = .failure(InternetError.fromServerError)
                } else {
                    result = .failure(InternetError.internetError)
                }
                print(response.statusCode)
                closure(result)
                return
            }
            print(post)
            result = .success(id)
            closure(result)
        }
        session.resume()
    }
    
   
    // TODO: исправить видимо
    func getEventInfo(eventId: Int, token: String, _ closure: @escaping (Result<PartyData, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/party/get_info?access_token=\(token)&party_id=\(eventId)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            var result: Result<PartyData, InternetError>
            guard
                let data = data,
                let post = try? JSONDecoder().decode(PartyData.self, from: data)
            else {
                guard let response = response as? HTTPURLResponse else { return }
                print(response.statusCode)
                if response.statusCode == 233 {
                    result = .failure(InternetError.fromServerError)
                } else {
                    result = .failure(InternetError.internetError)
                }
                print(response.statusCode)
                closure(result)
                return
            }
            print(post)
            result = .success(post)
            closure(result)
        }
        session.resume()
    }
    
    func getEventPhoto(token: String, id: Int, _ closure: @escaping (Result<UIImage, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/party/get_photo?access_token=\(token)&party_id=\(id)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            var result: Result<UIImage, InternetError>
            guard
                let data = data,
                let image = UIImage(data: data)

            else {
                guard let response = response as? HTTPURLResponse else { return }
                print(response.statusCode)
                if response.statusCode == 233 {
                    result = .failure(InternetError.fromServerError)
                } else {
                    result = .failure(InternetError.internetError)
                }
                print(response.statusCode)
                closure(result)
                return
            }
            print(data)
            let t = image
           
            result = .success(t)
            closure(result)
        }
        session.resume()
    }
    
    func verificationPassport(respond: VerificationModel) {
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
extension View {
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
         
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
         
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
         
        // here is the call to the function that converts UIView to UIImage: `.asImage()`
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}
extension UIView {
// This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
