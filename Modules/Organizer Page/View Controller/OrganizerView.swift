import Foundation

import SwiftUI
struct OrganizerView: View {
    @State private var searchText = "Find your event..."
    @State private var isSearching = false
    @State private var showingAlert = false
    var body: some View {
        
        NavigationView {
            VStack {
                ScrollView {
                    SearchBar(searchText: searchText, isSearching: isSearching)
                    
                }
            }
            .navigationBarTitle(Text("My events"))
            
            .navigationBarItems(
                trailing:
                Button(
                    action: {
                        
                    },
                    label: {
                        Image(systemName: "plus").resizable().frame(width: 20, height: 20)
                    }
                ).padding(.trailing, 10)
                    .padding(.top, 40)
            )
            .padding(.top, 10)
        }.padding(.top, -70)

    }
}

struct OrganizerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OrganizerView()
            OrganizerView()
                .preferredColorScheme(.dark)
        }
    }
}
