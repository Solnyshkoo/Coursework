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
            OrganizerView(output: OrganizerViewModel(service: service, user: people, newUser: newUser))
                .tabItem {
                    Image(systemName: "plus.app")
                }
                .tag(0)
            EventsView(fullAcсess: true)
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(1)
            FavoriteView(favoriteViewModel: FavoriteViewModel(service: service, user: people), user:  $people)
                .tabItem {
                    Image(systemName: "heart")
                }
                .tag(2)
            PersonalView(personalViewModel: PersonalViewModel(service: service, user: people, newUser: newUser), user: $people)
          //  PersonalView(output: PersonalViewModel(service: service, user: people, newUser: newUser))
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(3)
        }.accentColor(ColorPalette.text)
            
    }
}
