import Foundation

import SwiftUI
struct TabBar: View {
    @Binding var people: UserInfo
    var body: some View {
        TabView {
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
