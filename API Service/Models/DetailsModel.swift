import Foundation
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
