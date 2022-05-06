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
struct ClassicTextField2_Previews: View {
    @State var t: String = ""
    var body: some View {
        ClassicTextField(labelText: "lol", fieldText: "heh", user: $t)
        ClassicTextField(labelText: "lol", fieldText: "heh", user: $t)
            .preferredColorScheme(.dark)
    }
}

struct ClassicTextField_Previews: PreviewProvider {
    static var previews: some View {
        ClassicTextField2_Previews()
    }
}
