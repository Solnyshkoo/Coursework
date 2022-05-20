import Foundation

// MARK: - EmailResponse
struct EmailResponse: Codable {
    let response: ResponseEmail
}

// MARK: - Response
struct ResponseEmail: Codable {
    let email: String
}
