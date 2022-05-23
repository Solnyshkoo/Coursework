import Foundation

// MARK: - PartyData
struct PartyData: Codable {
    let response: ResponsePartyData
}

// MARK: - Response
struct ResponsePartyData: Codable {
    let address: String
    let creatorID: Int
    let comments: [Comment]
    let creatorName, responseDescription, endingAt, name: String
    let partyID, price: Int
    let startingAt: String
    let visitors: [Int]

    enum CodingKeys: String, CodingKey {
        case address, comments
        case creatorID = "creator_id"
        case creatorName = "creator_name"
        case responseDescription = "description"
        case endingAt = "ending_at"
        case name
        case partyID = "party_id"
        case price
        case startingAt = "starting_at"
        case visitors
    }
}
struct Comment: Codable {
    let author: Author
    let reviewID: Int
    let text: String

    enum CodingKeys: String, CodingKey {
        case author
        case reviewID = "review_id"
        case text
    }
}

// MARK: - Author
struct Author: Codable {
    let username: String
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case username
        case userID = "user_id"
    }
}
