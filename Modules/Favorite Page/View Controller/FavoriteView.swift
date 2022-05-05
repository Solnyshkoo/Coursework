import Foundation

import SwiftUI

struct FavoriteView: View {
   // @Binding var people: UserInfo

    @State private var searchText = ""
    @State private var isSearching = false
    var body: some View {
        NavigationView {
            ScrollView {
                SearchBar(searchText: searchText, isSearching: isSearching)
                FavoriteCell(event: EventModel(id: 1, name: "moscow.malina", logo: Image("logo"), mainPhoto: Image("logo"), distination: "16 км", price: "1000", description: "Очередная очень крутая тусовка, где будут все твои друзья с потока и самые-самые развлечения. Ах да, там будет фонк и даже дабстеп, так что надо что то написать, чтобы протестить", participant: 10, like: false, data: "34 марта"), people: UserInfo())
//                ForEach((people.favorities).filter { "\($0.shortTitle)".contains(searchText.lowercased()) || searchText.isEmpty }) { item in
//
//                }
            }
            .navigationTitle("Favorite")
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
struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FavoriteView()
            FavoriteView()
                .preferredColorScheme(.dark)
        }
    }
}
