import Foundation
enum InternetError: LocalizedError {
    case fromServerError
    case internetError

    var errorDescription: String? {
        switch self {
        case .fromServerError:
            return "Пожалуйста, попробуйте позже"
        case .internetError:
            return "Интернет соединение отсутсвует"
        }
    }
}
