import Foundation
import SwiftUI
import UIKit
final class Service {
    static let adress = "https://2cae-2a00-1370-8182-3789-c9ad-c734-b9fd-9b8f.ngrok.io"
    
    func getUsersData(token: String, _ closure: @escaping (Result<UserData, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/user/get_info?access_token=\(token)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, _ in
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
    
    func getUsersDataByID(token: String, id: Int, _ closure: @escaping (Result<UserData, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/user/get_info?access_token=\(token)&user_id=\(id)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, _ in
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
        let session = URLSession.shared.dataTask(with: url) { data, response, _ in
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
        let session = URLSession.shared.dataTask(with: url) { data, response, _ in
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
    
    func uploadUserPhoto(photo: Image, token: String, _ closure: @escaping (Result<Bool, Error>) -> Void) {
        let image: UIImage = photo.asUIImage()
        guard let url = URL(string: "\(Service.adress)/user/upload_photo?access_token=\(token)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
 
        let session = URLSession.shared
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest
        
        
        let d = image.pngData()
        let strBase64 = d!.base64EncodedString(options: .lineLength64Characters)
        
        var data = Data()
        data.append(d!)
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
//
//

//        var parameterJSON = JS([
//               "id_user": "test"
//           ])
//           // JSON stringify
//           let parameterString = parameterJSON.rawString(encoding: NSUTF8StringEncoding, options: nil)
//           let jsonParameterData = parameterString!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
//           // convert image to binary
//            let imageData = image.jpegData(compressionQuality: 0.7)
    }
    
    
    func uploadPartyPhoto() {
        
    }
    
    func createEvent(respond: EventModel, token: String, _ closure: @escaping (Result<Int, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/party/create?access_token=\(token)&name=\(respond.name)&description=\(respond.description)&address=\(respond.distination)&price=\(respond.price)&starting_at=\(respond.data)&ending_at=\(respond.contacts)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, _ in
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
        let session = URLSession.shared.dataTask(with: url) { data, response, _ in
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
        let session = URLSession.shared.dataTask(with: url) { data, response, _ in
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
    
    func verificationPassport(respond: VerificationModel) {}
    
    func setLike(token: String, index: Int, _ closure: @escaping (Result<Bool, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/user/add_favorite?access_token=\(token)&party_id=\(index)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { _, response, _ in
            var result: Result<Bool, InternetError>
            guard
                let response = response as? HTTPURLResponse
            else { return }
            if response.statusCode == 200 {
                result = .success(true)
            } else if response.statusCode == 404 {
                result = .failure(InternetError.internetError)
            } else {
                result = .failure(InternetError.fromServerError)
            }
            closure(result)
        }
        session.resume()
    }
    
    
    func deleteLike(token: String, index: Int, _ closure: @escaping (Result<Bool, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/user/delete_favorite?access_token=\(token)&party_id=\(index)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { _, response, _ in
            var result: Result<Bool, InternetError>
            guard
                let response = response as? HTTPURLResponse
            else { return }
            if response.statusCode == 200 {
                result = .success(true)
            } else if response.statusCode == 404 {
                result = .failure(InternetError.internetError)
            } else {
                result = .failure(InternetError.fromServerError)
            }
            closure(result)
        }
        session.resume()
    }

    func setGoingTo(token: String, index: Int, _ closure: @escaping (Result<Bool, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/user/add_going_to?access_token=\(token)&party_id=\(index)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { _, response, _ in
            var result: Result<Bool, InternetError>
            guard
                let response = response as? HTTPURLResponse
            else { return }
            if response.statusCode == 200 {
                result = .success(true)
            } else if response.statusCode == 404 {
                result = .failure(InternetError.internetError)
            } else {
                result = .failure(InternetError.fromServerError)
            }
            closure(result)
        }
        session.resume()
    }
    
    
    func deleteGoingTo(token: String, index: Int, _ closure: @escaping (Result<Bool, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/user/delete_going_to?access_token=\(token)&party_id=\(index)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { _, response, _ in
            var result: Result<Bool, InternetError>
            guard
                let response = response as? HTTPURLResponse
            else { return }
            if response.statusCode == 200 {
                result = .success(true)
            } else if response.statusCode == 404 {
                result = .failure(InternetError.internetError)
            } else {
                result = .failure(InternetError.fromServerError)
            }
            closure(result)
        }
        session.resume()
    }
    
    func getAllEvents(token: String, startIndex: Int, _ closure: @escaping (Result<AllEventsData, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/search/party?access_token=\(token)&index=\(startIndex)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, _ in
            var result: Result<AllEventsData, InternetError>
            guard
                let data = data,
                let parseData = try? JSONDecoder().decode(AllEventsData.self, from: data)
            else {
                guard let response = response as? HTTPURLResponse else { return }
                print(response.statusCode)
                if response.statusCode != 404 {
                    result = .failure(InternetError.fromServerError)
                } else {
                    result = .failure(InternetError.internetError)
                }
                print(response.statusCode)
                closure(result)
                return
            }
            result = .success(parseData)
            closure(result)
        }
        session.resume()
    }
    
    func addReview(token: String, partyId: Int, text: String, _ closure: @escaping (Result<Bool, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/review/create?access_token=\(token)&party_id=\(partyId)&text=\(text)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { _, response, _ in
            var result: Result<Bool, InternetError>
            guard
                let response = response as? HTTPURLResponse
            else { return }
            if response.statusCode == 200 {
                result = .success(true)
            } else if response.statusCode == 404 {
                result = .failure(InternetError.internetError)
            } else {
                result = .failure(InternetError.fromServerError)
            }
            closure(result)
        }
        session.resume()
    }
    
    func deleteReview(token: String, reviewId: Int, _ closure: @escaping (Result<Bool, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/review/create?access_token=\(token)&review_id=\(reviewId)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { _, response, _ in
            var result: Result<Bool, InternetError>
            guard
                let response = response as? HTTPURLResponse
            else { return }
            if response.statusCode == 200 {
                result = .success(true)
            } else if response.statusCode == 404 {
                result = .failure(InternetError.internetError)
            } else {
                result = .failure(InternetError.fromServerError)
            }
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

