import Foundation
import SwiftUI
struct EventsView: View {
    @State var lol: EventModel = EventModel(id: 1, name: "reading.club", logo: Image("logoRead"), mainPhoto: Image("photoRead"), distination: "", price: "100", description: "Привет! Мы приглашаем тебе на посиделки в антикафе. Обсудим книги, поделимся впечатлениемя. И да, каждого ждёт сюрприз", participant: 5, like: false, data: "20.05.2022", contacts: "")
    @State private var searchProperties: Set<String> = []
    var body: some View {
        // TODO: - скрол пофиксить + кнопка наверх
        VStack {
            VStack(alignment: .leading) {
                SearchBar(searchText: "Найди своё мероприятие", isSearching: false).padding(.bottom, 8)
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        CustomButton(searchProperties: $searchProperties, text: "Бесплатно", width: 100, height: 5)
                        CustomButton(searchProperties: $searchProperties, text: "Сегодня", width: 100, height: 5)
                        CustomButton(searchProperties: $searchProperties, text: "Завтра", width: 70, height: 5)
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
