import Foundation
import SwiftUI
final class OrganizerViewModel: ObservableObject {
    @Published var user: UserInfo
    @Published var warningText: String = ""
    @Published var showWarning: Bool = false
    let service: Service
    var token: String
    
    init(service: Service, user: UserInfo, newUser: Bool) {
        self.service = service
        self.token = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        if newUser {
            self.user = user
        } else {
            self.user = UserInfo()
            getUserData()
        }
    }
    
    func getUserData() {
        DispatchQueue.main.async {
            self.service.getUsersData(token: self.token) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.user = self.createUser(data: data)
                    }
                    
                case .failure:
                    DispatchQueue.main.async {
                        self.warningText = "Ошибка"
                        self.showWarning = true
                    }
                    // self.nicknameWarningText = "Bad internet connection"
                }
            }
        }
    }
    
    private func createUser(data: UserData) -> UserInfo {
        var array = data.response.favorites
        var fav: [EventModel] = []
        for i in 0..<array.capacity {
            fav.append(EventModel(id: array[i]))
        }
        array = data.response.partiesCreated
        var org:[EventModel] = []
        for i in 0..<array.capacity {
            org.append(EventModel(id: array[i]))
        }
        array = data.response.goingTo
        var sub:[EventModel] = []
        for i in 0..<array.capacity {
            sub.append(EventModel(id: array[i]))
        }
    
        return UserInfo(name:  data.response.user.firstName , surname: data.response.user.lastName , patronymic: "", age: -1, nickname: data.response.user.username , password: "", number: "", mail: data.response.user.email , sex: "", image: nil, validate: false, favorities: fav, subscribes: sub, organiesed: org)
    }
}
