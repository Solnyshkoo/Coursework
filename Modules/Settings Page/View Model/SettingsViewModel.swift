import Foundation
import SwiftUI
final class SettingsViewModel: ObservableObject {
    let service: Service
    @State var token: String
    @State var user: UserInfo
    @Published var editableUser: UserInfo
    @Published var mailConfirm: Bool = false
    @Published var passConfirm: Bool = false
    @Published var canSave: Bool = false
    @Published var code: String = ""
    @Published var pass: Bool = false
    init (service: Service, tok: String, user: UserInfo) {
        self.service = service
        token = tok
        self.user = user
        self.user =  UserInfo(name: "Ksenia", surname: "Petrova", patronymic: "Эдуардовна", age: 19, nickname: "ksu", password: "*********", number: "0000", mail: "kepetrova@edu.hse.ru", sex: "female", favorities: [], subscribes: [EventModel(id: 1, name: "reading.club", logo: Image("logoRead"), mainPhoto: Image("photoRead"), distination: "", price: "100", description: "Привет! Мы приглашаем тебе на посиделки в антикафе. Обсудим книги, поделимся впечатлениемя. И да, каждого ждёт сюрприз", participant: 5, like: false, data: "20.05.2022", contacts: "")], organiesed: [])
        self.editableUser = user
        self.editableUser =  UserInfo(name: "Ksenia", surname: "Petrova", patronymic: "Эдуардовна", age: 19, nickname: "ksu", password: "*********", number: "0000", mail: "kepetrova@edu.hse.ru", sex: "female", favorities: [], subscribes: [EventModel(id: 1, name: "reading.club", logo: Image("logoRead"), mainPhoto: Image("photoRead"), distination: "", price: "100", description: "Привет! Мы приглашаем тебе на посиделки в антикафе. Обсудим книги, поделимся впечатлениемя. И да, каждого ждёт сюрприз", participant: 5, like: false, data: "20.05.2022", contacts: "")], organiesed: [])
    }
    
    func saveChanges() {
        var origStr: String = user.mail
        var noChanges: Bool = true
        if origStr.trimmingCharacters(in: .whitespacesAndNewlines) != editableUser.mail.trimmingCharacters(in: .whitespacesAndNewlines) {
            mailConfirm = true
            noChanges = false
        }
        origStr = user.password
        if origStr.trimmingCharacters(in: .whitespacesAndNewlines) != editableUser.mail.trimmingCharacters(in: .whitespacesAndNewlines) {
            pass = true
            noChanges = false
        }
        if noChanges {
            canSave = true
        }
    }
    
    func cancelChanges() {
        editableUser = user
    }
}


