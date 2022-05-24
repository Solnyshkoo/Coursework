import Foundation

import SwiftUI

struct FavoriteView: View {
   // @Binding var people: UserInfo
    @ObservedObject  var favoriteViewModel: FavoriteViewModel = FavoriteViewModel(service: Service())
    @Binding var user: UserInfo
    @State private var searchText = ""
    @State private var isSearching = false
    var body: some View {
        NavigationView {
            ScrollView {
                SearchBar(searchText: searchText, isSearching: isSearching)
                ForEach($user.favorities) { item in
                    EventCell(info: item, people: $user, fullAcсess: true, canEdit: false)
                }
                .onAppear {
                    favoriteViewModel.getFavorites(user: user)
                    user.favorities = favoriteViewModel.events
                }
            }
            .navigationTitle("Избранное")
            .navigationBarBackButtonHidden(true)
            Spacer()
        }.padding(.top, -70)
    }
}

