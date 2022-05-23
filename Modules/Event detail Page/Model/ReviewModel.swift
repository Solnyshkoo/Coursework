import Foundation
import SwiftUI
struct ReviewModel: Identifiable {
    var id: Int = 0
    var logo: Image = Image(systemName: "circle")
    var nickname: String = ""
    var review: String = ""
}
