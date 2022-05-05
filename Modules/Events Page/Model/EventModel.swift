import Foundation
import SwiftUI
struct EventModel: Identifiable {
    var id: Int
    
    let name: String
    let logo: Image
    let mainPhoto: Image
    let distination: String
    let price: String
    let description: String
    let participant: Int
    let like: Bool
    let data: String
}
