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
    var favorities: [EventModel] = []
    var subscribes: [EventModel] = []
    var organiesed: [EventModel] = [EventModel(id: 1, name: "moscow.malina", logo: Image("logo"), mainPhoto: Image("photo"), distination: "16 км", price: "1000", description: "Очередная очень крутая тусовка, где будут все твои друзья с потока и самые-самые развлечения. Ах да, там будет фонк и даже дабстеп, так что надо что то написать, чтобы протестить", participant: 10, like: false, data: "34 марта")]
}

