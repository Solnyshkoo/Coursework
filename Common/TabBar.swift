import Foundation

import SwiftUI
struct TabBar: View {
    @State private var selection = 1
    @Binding var people: UserInfo
    var token: String
    var service: Service
    
    var body: some View {
        TabView(selection: $selection){
            OrganizerView()
                .tabItem {
                    Image(systemName: "plus.app")
                }
                .tag(0)
            EventsView(fullAcсess: true)
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(1)
            FavoriteView()
                .tabItem {
                    Image(systemName: "heart")
                }
                .tag(2)
            PersonalView(output: PersonalViewModel(service: service, tok: token))
                .tabItem {
                    Image(systemName: "person")
                }
                .tag(3)
        }.accentColor(ColorPalette.text)
            
    }
}
