import Foundation
import SwiftUI

final class LogInViewModel: ObservableObject {
    let service: AuthorizationAPIService
    let service2: Service
    @Published var signInFailed = " "
    @Published var signUpFailed = " "
    @Published var showSignUpAlert: Bool = false
    @Published var showHome = false
    @Published var codeSend: Bool = false
    @Published var showAllert: Bool = false
    @Published var wrongCode: Bool = false
    @Published var showHomeView = false
    @Published var showPasswordView: Bool = false
    @Published var successRestore = false
    @Published var showRestoreAlert = false
    @Published var emailUser = true
    @Published var showCodeView = false
    @Published var user: UserInfo = UserInfo()
    var codeRight: String = ""
    var mails: [String: String] = [:]
    var wrongMail = " "
    var failRestoreText = " "
    private var token = ""
    
    init(service: AuthorizationAPIService) {
        self.service = service
        service2 = Service()
    }
    
    func validateUser(respond: ValidateUserModel) {
        signInFailed = " "
        DispatchQueue.main.async {
            self.service.validateUserData(respond: respond) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let token):
                    UserDefaults.standard.set(token, forKey: "token")
                    DispatchQueue.main.async {
                        self.signInFailed = " "
                        self.token = token
                        print(token)
                        self.getData()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.signInFailed = error.errorDescription!
                    }
                }
            }
        }
    }
    
    func registrateUser(respond: UserInfo) {
        signUpFailed = " "
        DispatchQueue.main.async {
            self.service.registrateUser(respond: respond) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let token):
                    DispatchQueue.main.async {
                        self.signUpFailed = " "
                        self.token = token
                    
                        self.showHome = true
                        self.showSignUpAlert = false
                        UserDefaults.standard.set(token, forKey: "token")

                    }
                   
                case .failure(let error):
                    DispatchQueue.main.async {
                    self.showHome = false
                    self.signUpFailed = error.errorDescription!
                    self.showSignUpAlert = true
                    print(error.errorDescription!)
                    }
                }
            }
        }
    }
    
    
    func getData() {
        if token != "" {
            DispatchQueue.main.async {
                self.service2.getUsersData(token: self.token) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data): // TODO: исправить
                    DispatchQueue.main.async {
                        self.user = self.createUser(data: data)
                        self.getUserPhoto()
                        for i in 0..<self.user.subscribes.count {
                            self.getEventInfo(index: self.user.subscribes[i].id, i: i, array: 1)
                        }
                        for i in 0..<self.user.organiesed.count {
                            self.getEventInfo(index: self.user.organiesed[i].id, i: i,  array: 2)
                        }
                        
                        for i in 0..<self.user.favorities.count {
                            self.getEventInfo(index: self.user.favorities[i].id, i: i,  array: 3)
                           
                        }
                        self.showHomeView = true
                    }
                       
                case .failure:
                    break;
                }
            }
             }
        }
  
    }
    
    
    func getUserPhoto() {
        self.service2.getUserPhoto(token: self.token, nick: self.user.nickname) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.user.image = Image(uiImage: data)
                }
            case .failure:
                DispatchQueue.main.async {
                    self.user.image = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                }
            }
        }
    }
    
    func getEventInfo(index: Int, i: Int, array: Int) {
        var item = EventModel()
        DispatchQueue.main.async {
            self.service2.getEventInfo(eventId: index, token: self.token) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        item = self.createEvent(data: data)
                        if array == 1 {
                            self.user.subscribes[i] = self.createEvent(data: data)
                        } else if array == 2 {
                            self.user.organiesed[i] = self.createEvent(data: data)
                        } else {
                            self.user.favorities[i] = self.createEvent(data: data)
                        }
                      
                    }
                case .failure:
                    break
                }
            }
            
            self.service2.getEventPhoto(token: self.token, id: index) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        if array == 1 {
                            self.user.subscribes[i].mainPhoto = Image(uiImage: data)
                        } else if array == 2 {
                            self.user.organiesed[i].mainPhoto = Image(uiImage: data)
                        } else {
                            self.user.favorities[i].mainPhoto = Image(uiImage: data)
                        }
                    }
                case .failure:
                    DispatchQueue.main.async {
                        if array == 1 {
                            self.user.subscribes[i].mainPhoto = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                        } else if array == 2 {
                            self.user.organiesed[i].mainPhoto = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                        } else {
                            self.user.favorities[i].mainPhoto = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                        }
                    }
                }
            }
            
            self.service2.getUserPhoto(token: self.token, nick: item.creatorName) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        if array == 1 {
                            self.user.subscribes[i].logo = Image(uiImage: data)
                        } else if array == 2 {
                            self.user.organiesed[i].logo = Image(uiImage: data)
                        } else {
                            self.user.favorities[i].logo = Image(uiImage: data)
                        }
                    }
                case .failure:
                    DispatchQueue.main.async {
                        if array == 1 {
                            self.user.subscribes[i].logo = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                        } else if array == 2 {
                            self.user.organiesed[i].logo = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                        } else {
                            self.user.favorities[i].logo = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                        }
                    }
                }
            }
        }
    }
    
    
    private func createUser(data: UserData) -> UserInfo {
        var array = data.response.favorites
        var fav: [EventModel] = []
        for i in 0..<array.count {
            if let index = Int(array[i]) {
                fav.append(EventModel(id: index))
            }
        }
        let array2 = data.response.partiesCreated
        var org: [EventModel] = []
        print("_____d_")
        
        print("_____d_")
        for i in 0..<array2.count {
            org.append(EventModel(id: array2[i]))
        }
            
        array = data.response.goingTo
        var sub: [EventModel] = []
        for i in 0..<array.count {
            if let index = Int(array[i]) {
                sub.append(EventModel(id: index))
            }
        }
    
        var set = Settings()
        set.notificationsAboutGoingTo = (data.response.user.notificationsAboutGoingTo != 0)
        set.notifications_about_favorites = (data.response.user.notificationsAboutFavorites != 0)
        set.privateAccount = (data.response.user.privateAccount != 0)
        set.showCreated = (data.response.user.showCreated != 0)
        set.showGoingTo = (data.response.user.showGoingTo != 0)
        set.showList = (data.response.user.showList != 0)
        return UserInfo(name: data.response.user.firstName, surname: data.response.user.lastName, patronymic: "", age: data.response.user.age, nickname: data.response.user.username, password: "", mail:  data.response.user.email, sex: data.response.user.sex, image: nil, validate: (data.response.user.verified != 0), favorities: fav, subscribes: sub, organiesed: org, settings: set)
       
    }
    
    private func createEvent(data: PartyData) -> EventModel {
        var item = EventModel()
        item.id = data.response.partyID
        item.contacts = data.response.endingAt
        item.price = String(data.response.price)
        item.distination = data.response.address
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        item.data = dateFormatter.date(from: data.response.startingAt) ?? Date()
        print(data.response.startingAt)
        print( item.data)
        print(Date())
        item.description = data.response.responseDescription
        item.name = data.response.name
        item.creatorName = data.response.creatorName
        item.participant = data.response.visitors.count
        return item
    }
    
    func verifyEmail(email: String, nickname: String) {
        print("____7____")
        print(nickname)
        print("____8____")
        if let m = mails[nickname] {
            if m.trimmingCharacters(in: .whitespacesAndNewlines) == email {
                self.emailUser = false
                self.showCodeView = true
            } else {
                self.emailUser = true
                self.showCodeView = false
            }
        } else {
            DispatchQueue.main.async {
                self.service.getUserEmailByNickname(nickname: nickname) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let token):
                        DispatchQueue.main.async {
                            if token.trimmingCharacters(in: .whitespacesAndNewlines) == email {
                                self.mails[nickname] = token
                                self.emailUser = false
                                self.codeSend = true
                                self.showAllert = false
                                self.wrongMail = ""
                            } else {
                                self.emailUser = true
                                self.codeSend = false
                                self.showAllert = true
                                self.wrongMail = "Почта не соответсвует этому пользователю"
                            }
                        }
                       
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.emailUser = true
                            self.codeSend = false
                            self.showAllert = true
                            self.wrongMail = error.errorDescription ?? "Ошибка"
                        print(error.errorDescription!)
                        }
                    }
                }
            }
        }
    }
    
    func restorePassword(pass: String) {
        // TODO: вызов метода restoreUserPassword, если удачно то токен сохраняем
        successRestore = true
        showRestoreAlert = false
        failRestoreText = ""
        showHome = true
    }
    
    func sendCodeToEmail(email: String) {
        print("____6____")
        print(email)
        print("____6____")
        DispatchQueue.main.async {
            self.service.sendUserCodeToEmail(email: email) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let token):
                    DispatchQueue.main.async {
                    self.codeSend = true
                    self.codeRight = token
                    self.showAllert = false
                    self.wrongMail = ""
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                    self.codeSend = false
                    self.codeRight = ""
                    self.showAllert = true
                    self.wrongMail = error.errorDescription ?? "Ошибка"
                    }
                }
            }
        }
    }
    
    func checkEmailCode(сode: String) {
        if self.codeRight == сode {
            wrongMail = ""
            wrongCode = false
            showPasswordView = true
        } else {
            wrongMail = "Неправильный код"
            wrongCode = true
            showPasswordView = false
        }
    }

    func getText() -> String {
        return signInFailed
    }
    
    func getToken() -> String {
        return token
    }
    
    

    
    
}
