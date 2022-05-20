import Foundation
import Foundation

// MARK: - UserData
struct UserData: Codable {
    let response: UserResponse
}

// MARK: - Response
struct UserResponse: Codable {
    let favorites, goingTo: [Int]
    let partiesCreated: [Int]
    let user: User

    enum CodingKeys: String, CodingKey {
        case favorites
        case goingTo = "going_to"
        case partiesCreated = "parties_created"
        case user
    }
}

// MARK: - User
struct User: Codable {
    let email, firstName, lastName: String
    let photo: Int
    let username: String

    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case photo, username
    }
}
