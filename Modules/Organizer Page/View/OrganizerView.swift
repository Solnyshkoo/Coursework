import Foundation
import SwiftUI
struct OrganizerView: View {
    @State private var searchText = "Найди мероприятие..."
    @ObservedObject var organizerViewModel: OrganizerViewModel = .init(service: Service())
    @Binding var user: UserInfo
    @State private var isSearching = false
    @State private var showingAlert = false
    @State private var showingVerification = false
    @State private var showingNewEventPage = false
    @State private var verification = true
    @State private var respondSend = true
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    SearchBar(searchText: searchText, isSearching: isSearching)
                    ForEach($user.organiesed) { item in
                        EventCell(info: item, people: $user, fullAcсess: true, canEdit: true)
                            .onLongPressGesture {
                                Button {
                                        organizerViewModel.deleteParty(id: item.id)
                                    if organizerViewModel.deletEvent {
                                        user.organiesed.remove(at:
                                        user.organiesed.firstIndex(where: { $0.id == item.id })!)
                                    }
                                    } label: {
                                        Label("Удалить", systemImage: "trash")
                                    }
                            }
                    }
                }
            }
            .alert(organizerViewModel.warningText, isPresented: $organizerViewModel.showWarning) {
                Button("OK", role: .cancel) {}
            }
            .navigationBarTitle(Text("Мои мероприятия"))
            .navigationBarItems(
                trailing:
                Button(
                    action: {
                        if user.validate {
                            self.showingNewEventPage.toggle()
                        } else if user.sendRespond {
                            self.respondSend.toggle()
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
                    .alert("Вы отправили данные на валидацию. Дождитесь, пожалуйста их проверки.", isPresented: $respondSend) {
                        Button("OK", role: .cancel) {}
                    }
            )
            .padding(.top, 10)
        }.padding(.top, -70)
    }
}
