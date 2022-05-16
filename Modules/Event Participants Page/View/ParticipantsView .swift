import Foundation
import SwiftUI
struct ParticipantsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var users: [ParticipantsModel] = [ParticipantsModel(id: 1, name: "Катя", surname: "Иванова", nickname: "kate", photo: Image("logo"), show: true),
                                             ParticipantsModel(id: 2, name: "Иван", surname: "Иванов", nickname: "ivan", photo: Image("ivan"), show: true)]
    // TODO: -  из modelView
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(users) { item in
                        ParticipantsCell(user: item)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .navigation) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(ColorPalette.navigationBarItem)
                        .onTapGesture {
                            self.mode.wrappedValue.dismiss()
                        }
                }
            })
        }
    }
}

struct ParticipantsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ParticipantsView()
            ParticipantsView()
                .preferredColorScheme(.dark)
        }
    }
}
