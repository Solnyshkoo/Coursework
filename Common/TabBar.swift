import Foundation

import SwiftUI
struct TabBar: View {
    @Binding var people: UserInfo
    var token: String
    var service: Service
    var body: some View {
        TabView {
            PersonalView(output: PersonalViewModel(service: service, tok: token))
                .tabItem {
                    Image(systemName: "circle")
                }
            EventsView()
                .tabItem {
                    Image(systemName: "circle")
                }
//            OrganizerView()
//                .tabItem {
//                    Image("myEvents")
//                }
//            EventsView(people: $people)
//                .tabItem {
//                    Image("all")
//                }
//            PersonalView(people: $people)
//                .tabItem {
//                    Image("person")
//                        .resizable()
//                        .frame(width: 24, height: 24)
//                }
        }
    }
}
