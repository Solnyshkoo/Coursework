import Foundation
import SwiftUI
struct EventModel: Identifiable {
    var id: Int = -1
    var name: String = ""
    var creatorName: String = ""
    var logo: Image = Image(uiImage:UIImage(imageLiteralResourceName: "noImage"))
    var show: Bool = true
    var passed: Bool = false
    var mainPhoto: Image = Image(uiImage:UIImage(imageLiteralResourceName: "noImage"))
    var distination: String = ""
    var price: String = ""
    var description: String = ""
    var participant: Int = -1
    var like: Bool = false
    var data: Date = Date()
    var contacts: String = ""
    var visitors: [Int] = []
    var comments: [ReviewModel] = []
}
