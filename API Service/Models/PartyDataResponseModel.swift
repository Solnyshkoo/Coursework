import Foundation

// MARK: - PartyData
struct PartyData: Codable {
    let response: ResponsePartyData
}

// MARK: - Response
struct ResponsePartyData: Codable {
    let address: String
    let creatorID: Int
    let creatorName, responseDescription, endingAt, name: String
    let partyID, price: Int
    let startingAt: String

    enum CodingKeys: String, CodingKey {
        case address
        case creatorID = "creator_id"
        case creatorName = "creator_name"
        case responseDescription = "description"
        case endingAt = "ending_at"
        case name
        case partyID = "party_id"
        case price
        case startingAt = "starting_at"
    }
}
