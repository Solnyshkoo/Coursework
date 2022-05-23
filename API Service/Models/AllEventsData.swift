import Foundation

// MARK: - AllEventsData
struct AllEventsData: Codable {
    let response: ResponseAllEventsData
}

// MARK: - Response
struct ResponseAllEventsData: Codable {
    let index: Int
    let parties: [Party]
    let totalAmount: Int

    enum CodingKeys: String, CodingKey {
        case index, parties
        case totalAmount = "total_amount"
    }
}

// MARK: - Party
struct Party: Codable {
    let address: String
    let creatorID: Int
    let creatorName, partyDescription, endingAt, name: String
    let partyID, price: Int
    let startingAt: String
    let visitors: [Int]

    enum CodingKeys: String, CodingKey {
        case address
        case creatorID = "creator_id"
        case creatorName = "creator_name"
        case partyDescription = "description"
        case endingAt = "ending_at"
        case name
        case partyID = "party_id"
        case price
        case startingAt = "starting_at"
        case visitors
    }
}
