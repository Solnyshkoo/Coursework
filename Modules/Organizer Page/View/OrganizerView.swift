import Foundation
import SwiftUI
struct OrganizerView: View {
    @State private var searchText = "Найди мероприятие..."
    @ObservedObject var organizerViewModel: OrganizerViewModel = OrganizerViewModel(service: Service())
    @Binding var user: UserInfo
    @State private var isSearching = false
    @State private var showingAlert = false
    @State private var showingVerification = false
    @State private var showingNewEventPage = false
    @State private var verification = true
  
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    SearchBar(searchText: searchText, isSearching: isSearching)
                    ForEach($user.organiesed) { item in
                        EventCell(info: item, people: $user, fullAcсess: true, canEdit: true)
                    }
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
                        if user.validate {
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
                        NewEventView(newEventViewModel: NewEventViewModel(service: Service(), user: user), user: $user)
         
                    })
                    .sheet(isPresented: $showingVerification, content: {
                        VerificationView(verificationViewModel: VerificationViewModel(service: organizerViewModel.service, user: user), user: $user)
                    })
            )
            .padding(.top, 10)
        }.padding(.top, -70)

    }
}
