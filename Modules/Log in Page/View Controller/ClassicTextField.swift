import Foundation
import SwiftUI

struct ClassicTextField: View {
    var labelText: String
    var fieldText: String
    @Binding var user: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(labelText).font(.headline).fontWeight(.light).foregroundColor(Color(.label).opacity(0.75))
            HStack {
                TextField(fieldText, text: $user)
            }
            Divider()
        }
    }
}
