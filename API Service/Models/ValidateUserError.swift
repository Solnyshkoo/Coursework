import Foundation
enum ValidationError: LocalizedError {
    case noUser
    case wrongPassword
    case fatalEror

    var errorDescription: String? {
        switch self {
        case .noUser:
            return "No such user"
        case .wrongPassword:
            return "The password is wrong"
        case .fatalEror:
            return "Please, try later"
        }
    }
}
