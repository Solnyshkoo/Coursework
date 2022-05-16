import Foundation
import SwiftUI
struct ParticipantsCell: View {
    @State var user: ParticipantsModel =  ParticipantsModel(id: 1, name: "Катя", surname: "Иванова", nickname: "kate", photo: Image("logo"), show: true)
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if user.show { // TODO - аноним
                    user.photo
                        .resizable()
                        .centerSquareCropped()
                        .clipShape(Circle())
                        .frame(width: 50, height: 50)
                        .scaledToFit()
                        .padding(.leading, 20)
                        .padding(.trailing, 15)
                    VStack(alignment: .leading, spacing: 3, content: {
                        Text(user.name + " " + user.surname)
                            .foregroundColor(ColorPalette.text).font(.title3)
                            .padding(.trailing, 10)
                            .lineLimit(2)
                        Text("@" + user.nickname)
                            .foregroundColor(ColorPalette.text)
                            .padding(.trailing, 10)
                            .lineLimit(2)
                    })
                }
            }
            Divider()
        }.padding([.leading, .trailing], 10)
    }
}

struct ParticipantsCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ParticipantsCell(user: ParticipantsModel(id: 1, name: "Катя", surname: "Иванова", nickname: "kate", photo: Image("logo"), show: true))
            ParticipantsCell(user: ParticipantsModel(id: 1, name: "Катя", surname: "Иванова", nickname: "kate", photo: Image("logo"), show: true))
                .preferredColorScheme(.dark)
        }
    }
}
