import Foundation
import SwiftUI

struct SecretTextField: View {
    var labelText: String
    var fieldText: String
    @Binding var pass: String
    @State var hidde = true

    var body: some View {
        VStack(alignment: .leading) {
            Text(labelText).font(.headline).fontWeight(.light).foregroundColor(Color(.label).opacity(0.75))

            HStack {
                if self.hidde {
                    SecureField(fieldText, text: $pass)
                } else {
                    TextField(fieldText, text: $pass)
                }

                Button(action: { self.hidde.toggle()
                }) {
                    Image(systemName: self.hidde ?
                        "eye.slash.fill" : "eye.fill")
                        .foregroundColor(self.hidde ? Color.secondary // TODO: подумать над этим
                            : Color.green)
                }.offset(x: -15, y: 0)
            }
            Divider()
        }
    }
}
