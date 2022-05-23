import Foundation
import SwiftUI
struct ParticipantsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var participantsViewModel: ParticipantsViewModel
    // TODO: -  из modelView
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(participantsViewModel.party) { item in
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
