import Foundation

import SwiftUI

struct FavoriteView: View {
   // @Binding var people: UserInfo
    @ObservedObject  var favoriteViewModel: FavoriteViewModel
    @Binding var user: UserInfo
    @State private var searchText = ""
    @State private var isSearching = false
    var body: some View {
        NavigationView {
            ScrollView {
                SearchBar(searchText: searchText, isSearching: isSearching)
                ForEach($user.favorities) { item in
                    EventCell(info: item, people: $user, fullAcсess: true, canEdit: false,  eventCellView: favoriteViewModel)
                }
               
//                ForEach((people.favorities).filter { "\($0.shortTitle)".contains(searchText.lowercased()) || searchText.isEmpty }) { item in
//
//                }
            }
            .navigationTitle("Избранное")
            .navigationBarBackButtonHidden(true)
//            .toolbar(content: {
//                ToolbarItem(placement: .navigation) {
//                    Image(systemName: "arrow.left")
//                        .foregroundColor(ColorPalette.navigationBarItem)
//                        .onTapGesture {
//
//                        }
//                }
//            })
            Spacer()
        }.padding(.top, -70)
    }
}
//struct FavoriteView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            FavoriteView()
//            FavoriteView()
//                .preferredColorScheme(.dark)
//        }
//    }
//}
