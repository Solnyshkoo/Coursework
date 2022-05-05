import Foundation
enum RegistrationUserError: LocalizedError {
    case loginIsBusy
    case alreadyExists
    case fatalEror

    var errorDescription: String? {
        switch self {
        case .loginIsBusy:
            return "The login is busy"
        case .alreadyExists:
            return "User with this email is already exists"
        case .fatalEror:
            return "Please, try later"
        }
    }
}
