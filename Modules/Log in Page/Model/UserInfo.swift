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
    var image: Image?
    var validate: Bool = false
    var sendRespond: Bool = false
    var favorities: [EventModel] = []
    var subscribes: [EventModel] = []
    var organiesed: [EventModel] = []
    var settings: Settings = Settings()
}


struct Settings {
    var privateAccount: Bool = true
    var showGoingTo: Bool = true
    var showCreated: Bool = true
    var showList: Bool = true
    var notificationsAboutGoingTo: Bool = true
    var notifications_about_favorites: Bool = true
}

