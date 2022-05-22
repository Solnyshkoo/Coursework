import Foundation
import SwiftUI



struct OrganizerView: View {
    @State private var searchText = "Найди мероприятие..."
    @ObservedObject var organizerViewModel: OrganizerViewModel
    @State private var isSearching = false
    @State private var showingAlert = false
    @State private var showingVerification = false
    @State private var showingNewEventPage = false
    @State private var verification = true
    init(output: OrganizerViewModel) {
        organizerViewModel = output
    }
    var body: some View {
        
        NavigationView {
            VStack {
                ScrollView {
                    SearchBar(searchText: searchText, isSearching: isSearching)
//                    ForEach(organizerViewModel.user.organiesed) { item in
//                        EventCell(info: item, fullAcсess: true, canEdit: true)
              //      }
                }
            }
            .alert(organizerViewModel.warningText, isPresented: $organizerViewModel.showWarning) {
                Button("OK", role: .cancel) { }
            }
            .navigationBarTitle(Text("Мои мероприятия"))
            
            .navigationBarItems(
                trailing:
                Button(
                    action: {
                        if organizerViewModel.user.validate {
                            self.showingNewEventPage.toggle()
                        } else {
                            self.showingVerification.toggle()
                        }
                    },
                    label: {
                        Image(systemName: "plus").resizable().frame(width: 20, height: 20)
                    }
                ).padding(.trailing, 10)
                    .padding(.top, 40)
                    .fullScreenCover(isPresented: $showingNewEventPage, content: {
                        NewEventView(output: NewEventViewModel(service: organizerViewModel.service, user: organizerViewModel.user))
                    })
                    .sheet(isPresented: $showingVerification, content: {
                        VerificationView(output: VerificationViewModel(service: organizerViewModel.service, user: organizerViewModel.user))
                    })
            )
            .padding(.top, 10)
        }.padding(.top, -70)

    }
}

struct OrganizerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OrganizerView(output: OrganizerViewModel(service: Service(), user: UserInfo(), newUser: false))
            OrganizerView(output: OrganizerViewModel(service: Service(), user: UserInfo(), newUser: false))
                .preferredColorScheme(.dark)
        }
    }
}
