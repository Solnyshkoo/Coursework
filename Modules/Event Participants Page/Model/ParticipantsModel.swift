import Foundation
import SwiftUI
struct ParticipantsModel: Identifiable {
    var id: Int
    let name: String
    let surname: String
    let nickname: String
    let photo: Image
    let show: Bool
}
