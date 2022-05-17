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
                EventCell(info: EventModel(id: 1, name: "reading.club", logo: Image("logoRead"), mainPhoto: Image("photoRead"), distination: "", price: "100", description: "Привет! Мы приглашаем тебе на посиделки в антикафе. Обсудим книги, поделимся впечатлениемя. И да, каждого ждёт сюрприз", participant: 5, like: false, data: "20.05.2022", contacts: ""), people: UserInfo(), fullAcсess: true)
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
struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FavoriteView()
            FavoriteView()
                .preferredColorScheme(.dark)
        }
    }
}
