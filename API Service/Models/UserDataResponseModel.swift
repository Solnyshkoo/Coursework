import Foundation

// MARK: - UserData

struct UserData: Codable {
    let response: UserResponse
}

// MARK: - Response

struct UserResponse: Codable {
    let favorites, goingTo: [String]
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
    let age: Int
    let email, firstName, lastName: String
    let notificationsAboutFavorites, notificationsAboutGoingTo, photo, privateAccount: Int
    let sex: String
    let showCreated, showGoingTo, showList: Int
    let username: String
    let verified: Int

    enum CodingKeys: String, CodingKey {
        case age, email
        case firstName = "first_name"
        case lastName = "last_name"
        case notificationsAboutFavorites = "notifications_about_favorites"
        case notificationsAboutGoingTo = "notifications_about_going_to"
        case photo
        case privateAccount = "private_account"
        case sex
        case showCreated = "show_created"
        case showGoingTo = "show_going_to"
        case showList = "show_list"
        case username, verified
    }
}
