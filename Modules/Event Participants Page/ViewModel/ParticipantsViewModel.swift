import Foundation
import SwiftUI
final class ParticipantsViewModel: ObservableObject {
    var token: String
    let service: Service
    @Published var party: [ParticipantsModel] = []
    
    init(service: Service, visitors: [Int]) {
        self.service = service
        self.token = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        
        for i in 0..<visitors.count {
            let index = self.party.count
            getUserInfo(user_id: visitors[i], index: index)
        }
    }
    
    
    func getUserInfo(user_id: Int, index: Int) {
        DispatchQueue.main.async {
            self.service.getUsersDataByID(token: self.token, id: user_id) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let data):
                    self.party.append(self.createParticipants(data: data))
                    self.party[index].id = user_id
                    break
                case .failure(let error):
                    break
                }
            }
            self.service.getUserPhoto(token: self.token, nick: self.party[index].nickname) { [weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.party[index].photo = Image(uiImage: data)
                    }
                case .failure:
                    DispatchQueue.main.async {
                        self.party[index].photo = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
                    }
                }
            }
        }
    }
    
    
    
    func createParticipants(data: UserData) -> ParticipantsModel {
        return ParticipantsModel(id: 0, name:  data.response.user.firstName , surname:  data.response.user.lastName, nickname: data.response.user.username, show: true)
    }
}
