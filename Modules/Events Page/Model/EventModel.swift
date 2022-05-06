import Foundation
import SwiftUI
struct EventModel: Identifiable {
    var id: Int = -1
    
    var name: String = ""
    var logo: Image = Image(systemName: "circle")
    var mainPhoto: Image = Image(systemName: "circle")
    var distination: String = ""
    var price: String = ""
    var description: String = ""
    var participant: Int = -1
    var like: Bool = false
    var data: String = ""
}
