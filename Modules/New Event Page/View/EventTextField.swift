import Foundation
import SwiftUI

struct EventTextField: View {
    @Binding var text: String
    var title: String
    var subtitile: String
    var width: CGFloat
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.title2).fontWeight(.light).foregroundColor(ColorPalette.text).padding(.leading, 18)
                .padding(.bottom, -1)
            HStack {
                TextField(subtitile, text: $text)
                    .font(.title3)
                    .padding(.leading, 15)
                    .padding(.top, -(width / 2 - 15))
                    .frame(height: width)
                    .background(ColorPalette.secondBackground)
                    .cornerRadius(10)
                    
            }.padding([.leading, .trailing ], 8)
        }
    }
}

struct EventTextField2_Previews: View {
    @State var t: String = ""
    var body: some View {
        EventTextField(text: $t, title: "Название", subtitile: "In Tusa", width: 100)
        EventTextField(text: $t, title: "Название", subtitile: "In Tusa", width: 100)
            .preferredColorScheme(.dark)
    }
}

struct EventTextField_Previews: PreviewProvider {
    static var previews: some View {
        EventTextField2_Previews()
    }
}
