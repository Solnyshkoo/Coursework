import Foundation
import SwiftUI
import UIKit
final class Service {
    static let adress = "https://62a0-2a00-1370-8182-3789-9457-f89e-4b8e-f2e7.ngrok.io"
    
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
    
    
    func changeUserName(token: String, name: String, _ closure: @escaping (Result<Bool, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/user/change/first_name?first_name=\(name)&access_token=\(token)".encodeUrl) else {
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
    
    
    func changeUserSurname(token: String, name: String, _ closure: @escaping (Result<Bool, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/user/change/last_name?last_name=\(name)&access_token=\(token)".encodeUrl) else {
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
    
    
    func changeUserEmail(token: String, name: String, _ closure: @escaping (Result<Bool, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/user/change/email?email=\(name)&access_token=\(token)".encodeUrl) else {
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
    
    func changeUserPassword(token: String, name: String, _ closure: @escaping (Result<Bool, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/user/change/password?password=\(name)&access_token=\(token)".encodeUrl) else {
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
    
    
    func getUserPhoto(token: String, nick: String, _ closure: @escaping (Result<UIImage, ChangeUserDataError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/user/get_photo?access_token=\(token)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, _ in
            var result: Result<UIImage, ChangeUserDataError>
         
            guard
                let data = data,
                let image = try? JSONDecoder().decode(Lol.self, from: data)
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
            let str = image.response.image as String
            let newString =  str.replacingOccurrences(of: " ", with: "+")
        
            guard let newBase64String =  newString.components(separatedBy: ",").last else {
                     return
                 }
            guard let imgNSData = NSData(base64Encoded: newBase64String, options: NSData.Base64DecodingOptions()) else {
                 return
             }
            guard let codeImage = UIImage(data: imgNSData as Data) else {
                 return
            }
            result = .success(codeImage)
            closure(result)
        }
        session.resume()
    }
    
    func uploadUserPhoto(photo: Image, token: String, _ closure: @escaping (Result<Bool, InternetError>) -> Void) {
        let image: UIImage = photo.asUIImage()
        let data = image.jpegData(compressionQuality: 0.0)
        let base64String = data!.base64EncodedString()
        guard let url = URL(string: "\(Service.adress)/user/upload_photo?access_token=\(token)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
       let parameters: [String: String] = ["name": base64String]
       var request = URLRequest(url: url)
       request.httpMethod = "POST"
          do {
              request.httpBody = try JSONSerialization.data(withJSONObject: parameters) // pass dictionary to nsdata object and set it as request body

          } catch let error {
              print(error.localizedDescription)
          }
        let session = URLSession.shared.dataTask(with: request) { _, response, _ in
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
        print(base64String)
        session.resume()
    }
    
    
    func getEventPhoto(token: String, id: Int, _ closure: @escaping (Result<UIImage, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/party/get_photo?access_token=\(token)&party_id=\(id)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, _ in
            var result: Result<UIImage, InternetError>
            print(data)
            guard
                let data = data,
                let post = try? JSONSerialization.jsonObject(with: data, options: .json5Allowed) as? [String: Any],
                let results = post["response"] as? [String: Any],
                let pages = results["image"] as? String
//                let image = try? JSONDecoder().decode(Kek.self, from: data)

            else {
                guard let response = response as? HTTPURLResponse else { return }
                print(response)
                print(response.statusCode)
                if response.statusCode == 233 {
                    result = .failure(InternetError.fromServerError)
                } else {
                    result = .failure(InternetError.internetError)
                }
              
                closure(result)
                return
            }
            print(pages)
            let str = pages
            let newString =  str.replacingOccurrences(of: " ", with: "+")
        
            guard let newBase64String =  newString.components(separatedBy: ",").last else {
                     return
                 }
            guard let imgNSData = NSData(base64Encoded: newBase64String, options: NSData.Base64DecodingOptions()) else {
                 return
             }
            guard let codeImage = UIImage(data: imgNSData as Data) else {
                 return
            }
            result = .success(codeImage)
            closure(result)
        }
        session.resume()
    }
    
    func uploadPartyPhoto(photo: Image, token: String, id: Int, _ closure: @escaping (Result<Bool, InternetError>) -> Void)  {
        let image: UIImage = photo.asUIImage()
        let data = image.jpegData(compressionQuality: 0.0)
        let base64String = data!.base64EncodedString()
        guard let url = URL(string: "\(Service.adress)/party/upload_photo?access_token=\(token)&party_id=\(id)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
       let parameters: [String: String] = ["name": base64String]
       var request = URLRequest(url: url)
       request.httpMethod = "POST"
          do {
              request.httpBody = try JSONSerialization.data(withJSONObject: parameters) // pass dictionary to nsdata object and set it as request body

          } catch let error {
              print(error.localizedDescription)
          }
        let session = URLSession.shared.dataTask(with: request) { _, response, _ in
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

    
    func changePartyDate(token: String, time: Date, id: Int, _ closure: @escaping (Result<Bool, InternetError>) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        var data = dateFormatter.string(from: time)
        guard let url = URL(string: "\(Service.adress)/party/change/starting_at?starting_at=\(data)&access_token=\(token)&party_id=\(id)".encodeUrl) else {
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
    
    func changePartyName(token: String, name: String, id: Int,  _ closure: @escaping (Result<Bool, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/party/change/name?name=\(name)&access_token=\(token)&party_id=\(id)".encodeUrl) else {
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
    
    
    func changePartyContacts(token: String, contacts: String,  id: Int, _ closure: @escaping (Result<Bool, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/party/change/ending_at?ending_at=\(contacts)&access_token=\(token)&party_id=\(id)".encodeUrl) else {
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
    
    
    
    func changePartyPrice(token: String, price: Int, id: Int, _ closure: @escaping (Result<Bool, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/change/price?price=\(price)&access_token=\(token)&party_id=\(id)".encodeUrl) else {
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
    
    
    func changePartyDescription(token: String, description: String, id: Int, _ closure: @escaping (Result<Bool, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/party/change/description?description=\(description)&access_token=\(token)&party_id=\(id)".encodeUrl) else {
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
    
    func changePartyAdress(token: String, adress: String, id: Int, _ closure: @escaping (Result<Bool, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/party/change/address?address=\(adress)&access_token=\(token)&party_id=\(id)".encodeUrl) else {
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
    
    
    func deleteParty(token: String, id: Int, _ closure: @escaping (Result<Bool, InternetError>) -> Void) {
        guard let url = URL(string: "\(Service.adress)/party/delete?&access_token=\(token)&party_id=\(id)".encodeUrl) else {
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
    
    
    func createEvent(respond: EventModel, token: String, _ closure: @escaping (Result<Int, InternetError>) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        var data = dateFormatter.string(from: respond.data)
        guard let url = URL(string: "\(Service.adress)/party/create?access_token=\(token)&name=\(respond.name)&description=\(respond.description)&address=\(respond.distination)&price=\(respond.price)&starting_at=\(data)&ending_at=\(respond.contacts)".encodeUrl) else {
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

// MARK: - Lol
struct Lol: Codable {
    let response: ResponseLol
}

// MARK: - Response
struct ResponseLol: Codable {
    let image: String
}
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: quality.rawValue)
    }
}

import Foundation

// MARK: - Kek
struct Kek: Codable {
    let response: ResponseKek
}

// MARK: - Response
struct ResponseKek: Codable {
    let image: String
}
