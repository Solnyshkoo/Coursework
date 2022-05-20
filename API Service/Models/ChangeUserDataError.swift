import Foundation
enum ChangeUserDataError: LocalizedError {
    case busy
    case fatalEror

    var errorDescription: String? {
        switch self {
        case .busy:
            return "Логин занят"
        case .fatalEror:
            return "Пожалуйста, попробуйте позже"
        }
    }
}
