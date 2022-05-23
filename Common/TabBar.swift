import Foundation

import SwiftUI
struct TabBar: View {
    @State private var selection = 3
    @State var newUser: Bool
    @Binding var people: UserInfo
    var token: String
    var service: Service
    
    var body: some View {
        TabView(selection: $selection){
            OrganizerView(organizerViewModel: OrganizerViewModel(service: service, user: people), user: $people)
                .tabItem {
                    Image(systemName: "plus.app")
                }
                .tag(0)
            EventsView(personalViewModel: EventsViewModel(service: service, user: people), user: $people, fullAcсess: true)
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(1)
            FavoriteView(favoriteViewModel: FavoriteViewModel(service: service, user: people), user:  $people)
                .tabItem {
                    Image(systemName: "heart")
                }
                .tag(2)
            PersonalView(personalViewModel: PersonalViewModel(service: service, user: people), user: $people)
         
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(3)
        }.accentColor(ColorPalette.text)
            
    }
}
