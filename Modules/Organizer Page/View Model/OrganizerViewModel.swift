import Foundation
import SwiftUI
final class OrganizerViewModel: ObservableObject {
  //  @Published var user: UserInfo
    @Published var warningText: String = ""
    @Published var showWarning: Bool = false
    @Published var deletEvent: Bool = false
    let service: Service
    var token: String
    
    init(service: Service) {
        self.service = service
        self.token = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        print("init - OrganizerViewModel")
 //      self.user = user
    }
    
  
    
    private func createUser(data: UserData) -> UserInfo {
        var array = data.response.favorites
        var fav: [EventModel] = []
        for i in 0..<array.count {
            if let index = Int(array[i]) {
            fav.append(EventModel(id: index))
            }
        }
        let array2 =  data.response.partiesCreated
        var org:[EventModel] = []
        print("____e__")
        print(array2.count)
        print("____e__")
        for i in 0..<array2.count {
           
            org.append(EventModel(id: array2[i]))
            
        }
            
        array = data.response.goingTo
        var sub:[EventModel] = []
        for i in 0..<array.count {
            if let index = Int(array[i]) {
                sub.append(EventModel(id: index))
            }
        }
    
        return UserInfo(name:  data.response.user.firstName , surname: data.response.user.lastName , patronymic: "", age: -1, nickname: data.response.user.username , password: "", number: "", mail: data.response.user.email , sex: "", image: nil, validate: false, favorities: fav, subscribes: sub, organiesed: org)
    }
    
    
    
    func deleteParty(id: Int) {
        DispatchQueue.main.async {
            self.service.deleteParty(token: self.token, id: id) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.deletEvent = data
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.warningText = error.errorDescription!
                        self.showWarning = true
                    }
                }
            }
        }
    }
}
