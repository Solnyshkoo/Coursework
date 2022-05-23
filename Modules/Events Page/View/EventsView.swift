import Foundation
import SwiftUI
struct EventsView: View {
    @ObservedObject  var personalViewModel: EventsViewModel
    @Binding var user: UserInfo
    @State private var searchProperties: Set<String> = []
    @State var fullAcсess: Bool
    var body: some View {
            VStack {
                VStack(alignment: .leading) {
                    SearchBar(searchText: "Найди своё мероприятие", isSearching: false)
                        .padding(.top, 5)
                        .padding(.bottom, 8)
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            CustomButton(searchProperties: $searchProperties, text: "Бесплатно", width: 100, height: 5)
                            CustomButton(searchProperties: $searchProperties, text: "Сегодня", width: 100, height: 5)
                            CustomButton(searchProperties: $searchProperties, text: "Завтра", width: 70, height: 5)
                        }

                    }.padding(.leading, 20)
                        .padding(.bottom, 8)
                    ScrollView {
                        ForEach($personalViewModel.allEvents) { item in
                            EventCell(info: item, people: $user, fullAcсess: fullAcсess, canEdit: false, eventCellView: FavoriteViewModel(service: personalViewModel.service, user: user))
                        }
                    }
                }
                Spacer()

                Spacer()
            }
        
    }
}
