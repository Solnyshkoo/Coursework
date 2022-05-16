import Foundation
import Foundation

// MARK: - UserData
struct UserData: Codable {
    let response: UserResponse
}

// MARK: - Response
struct UserResponse: Codable {
    let firstName, lastName, email, phone: String?
    let username: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email, phone, username
    }
}
