import Foundation
import SwiftUI

struct SearchBar: View {
    @State var searchText: String
    @State var isSearching: Bool

    var body: some View {
        HStack {
            HStack {
                TextField(searchText, text: $searchText)
                    .padding(.leading, 32)
                    .foregroundColor(ColorPalette.lightGray)
                    
            }.padding(8)
                .background(ColorPalette.secondBackground)
                .cornerRadius(10)
                .padding(.horizontal)
                .onTapGesture(perform: {
                    isSearching = true
                })
                .animation(.spring())

            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = "Find your event ..."
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Image(systemName: "xmark.circle.fill").foregroundColor(ColorPalette.text)
                     .padding(.trailing)
                    .padding(.leading, 0)
                }
                .transition(.move(edge: .trailing))
                .animation(.spring())
            }
        }
     
    }
}

struct SearchBarPreviewContainer_2: View {
    @State var lol = ""
    @State var lol2 = false
    var body: some View {
        SearchBar(searchText: lol, isSearching: lol2)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarPreviewContainer_2()
            .preferredColorScheme(.dark)
    }
}
