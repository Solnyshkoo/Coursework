import Foundation
enum ChangeUserDataError: LocalizedError {
    case busy
    case fatalEror

    var errorDescription: String? {
        switch self {
        case .busy:
            return "Busy"
        case .fatalEror:
            return "Please, try later"
        }
    }
}
