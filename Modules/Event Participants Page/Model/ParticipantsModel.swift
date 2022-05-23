import Foundation
import SwiftUI
struct ParticipantsModel: Identifiable {
    var id: Int = 0
    var name: String  = ""
    var surname: String = ""
    var nickname: String = ""
    var photo: Image = Image(uiImage: UIImage(imageLiteralResourceName: "noImage"))
    var show: Bool = true
}
