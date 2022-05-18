import Foundation
import SwiftUI
import UIKit
final class Service {
    static let adress = "https://f170-2a00-1370-8182-3789-f896-9860-1916-8cee.ngrok.io"
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
                result = .failure(error!) //TODO мб nill
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
                let _ = try? JSONSerialization.jsonObject(with: data, options: .json5Allowed) as? [String: Any]
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
    
    func uploadUserPhoto(photo: Image , token: String,  _ closure: @escaping (Result<Bool, Error>) -> Void) {
        let image : UIImage = photo.asUIImage()
//        let imageData: Data = uiimage.pngData() ?? Data()
//        let str: String = imageData.base64EncodedString()
////        let json: [String: NSData] = ["media":photo]
////        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        guard let url = URL(string: "\(Service.adress)/user/upload_photo?access_token=\(token)".encodeUrl) else {
            print("что-то не то с твоим запросом...")
            return
        }
        let boundary = UUID().uuidString

        let session = URLSession.shared

        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"

        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
       // urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()
        
        
       // data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
       // data.append("Content-Disposition: form-data;".data(using: .utf8)!)
       // data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)
       // data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        print(String(decoding: data, as: UTF8.self))
        
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print(json)
                }
            } else {
                print(error)
                print(responseData)
            }
        }).resume()
        
        // insert json data to the request
//        request.httpBody = jsonData
//        let session = URLSession.shared.dataTask(with: request) { data, response, error in
//            var result: Result<Bool, Error>
//            guard
//                let data = data,
//                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
//            else {
//                print(error)
//                result = .failure(error!)
//                closure(result)
//                return
//            }
//
//                if let responseJSON = responseJSON as? [String: NSData] {
//                    print(responseJSON)
//                }
//            result = .success(true)
//            closure(result)
//        }
//        session.resume()
        
    }
    
    func uploadImage(paramName: String, fileName: String, image: UIImage) {
        let url = URL(string: "http://api-host-name/v1/api/uploadfile/single")

        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString

        let session = URLSession.shared

        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"

        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()

        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)

        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print(json)
                }
            } 
        }).resume()
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
