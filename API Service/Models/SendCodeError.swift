import Foundation
enum SendCodeError: LocalizedError {
    case wrongMail
    case internetError

    var errorDescription: String? {
        switch self {
        case .wrongMail:
            return "Почта неправильная"
        case .internetError:
            return "Интернет соединение отсутсвует"
        }
    }
}
