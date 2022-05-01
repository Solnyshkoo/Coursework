import Foundation
import SwiftUI
struct UserInfo {
    var name: String = ""
    var surname: String = ""
    var patronymic: String = ""
    var age: Int = -1
    var nickname: String = ""
    var password: String = ""
    var number: String = ""
    var mail: String = ""
    var sex: String = ""
    var image: UIImage?
    var favorities: [EventsModel] = []
    var subscribes: [EventsModel] = []
}
struct EventsModel: Identifiable {
    let id: Int
    let shortTitle: String
    let image: Image
}
