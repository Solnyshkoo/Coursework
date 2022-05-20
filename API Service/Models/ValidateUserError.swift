import Foundation
enum ValidationError: LocalizedError {
    case noUser
    case wrongPassword
    case fatalEror

    var errorDescription: String? {
        switch self {
        case .noUser:
            return "Нет такого пользователя"
        case .wrongPassword:
            return "Неверный пароль"
        case .fatalEror:
            return "Пожалуйста, попробуйте позже"
        }
    }
}
