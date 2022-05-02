import Foundation
import SwiftUI
struct EventsView: View {
    @State var lol: EventModel = .init(name: "moscow.malina", logo: Image("logo"), mainPhoto: Image("photo"), distination: "16 км", price: "1000", description: "Очередная очень крутая тусовка, где будут все твои друзья с потока и самые-самые развлечения. Ах да, там будет фонк и даже дабстеп, так что надо что то написать, чтобы протестить", participant: 10, like: false, data: "34 марта")
    @State private var searchProperties: Set<String> = []
    var body: some View {
        // TODO: - скрол пофиксить + кнопка наверх
        VStack {
            VStack(alignment: .leading) {
                SearchBar(searchText: "Find our event", isSearching: false).padding(.bottom, 8)
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        CustomButton(searchProperties: $searchProperties, text: "Free", width: 80, height: 10)
                        CustomButton(searchProperties: $searchProperties, text: "Today", width: 80, height: 10)
                        CustomButton(searchProperties: $searchProperties, text: "Near", width: 80, height: 10)
                    }

                }.padding(.leading, 20)
                    .padding(.bottom, 8)
                ScrollView {
                    EventCell(info: lol)
                }
            }
            Spacer()

            Spacer()
        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            EventsView().preferredColorScheme($0)
        }
    }
}
