import Foundation
import SwiftUI



struct OrganizerView: View {
    @State private var searchText = "Найди мероприятие..."
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
                    
                }
            }
            .navigationBarTitle(Text("Мои мероприятия"))
            
            .navigationBarItems(
                trailing:
                Button(
                    action: {
                        if verification {
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
                        NewEventView()
                    })
                    .sheet(isPresented: $showingVerification, content: {
                        VerificationView()
                    })
            )
            .padding(.top, 10)
        }.padding(.top, -70)

    }
}

struct OrganizerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OrganizerView()
            OrganizerView()
                .preferredColorScheme(.dark)
        }
    }
}
