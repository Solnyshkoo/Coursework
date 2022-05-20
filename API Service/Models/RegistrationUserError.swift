import Foundation
enum RegistrationUserError: LocalizedError {
    case loginIsBusy
    case alreadyExists
    case fatalEror

    var errorDescription: String? {
        switch self {
        case .loginIsBusy:
            return "Логин занят"
        case .alreadyExists:
            return "Почта уже зарегистрированна"
        case .fatalEror:
            return "Пожалуйста, попробуйте позже"
        }
    }
}
