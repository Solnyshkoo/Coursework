import Foundation
import SwiftUI
final class SettingsViewModel: ObservableObject {
    let service: Service
    @State var token: String
    @State var user: UserInfo
    @Published var editableUser: UserInfo
    @Published var photo: UIImage?
    @Published var mailConfirm: Bool = false
    @Published var passConfirm: Bool = false
    @Published var canSave: Bool = false
    @Published var saveChanges: Bool = false
    @Published var warningAllChanges: Bool = false
    @Published var allFields: Bool = false
    @Published var notAllFieldsWarning: Bool = false
    @Published var warning: String = ""
    @Published var code: String = ""
    @Published var pass: Bool = false
    init (service: Service, tok: String, user: UserInfo) {
        self.service = service
        token = tok
        self.user = user
        self.editableUser = user
        photo =  UIImage(imageLiteralResourceName: "noImage") 

    }
    
    func saveAllChanges() {
       
    }
    
    func checkAllChanges() {
        if editableUser.nickname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            allFields = false
            notAllFieldsWarning = true
            warning = "Отсутвует nickanme"
        } else if editableUser.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            allFields = false
            notAllFieldsWarning = true
            warning = "Отсутвует имя"
        } else if editableUser.surname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            allFields = false
            notAllFieldsWarning = true
            warning = "Отсутвует фамилия"
        } else if editableUser.age == -1 {
            allFields = false
            notAllFieldsWarning = true
            warning = "Отсутвует возраст"
        } else {
            allFields = true
            notAllFieldsWarning = false
            warning = ""
        }
    }
    
    func saveSecurityChanges() {
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


