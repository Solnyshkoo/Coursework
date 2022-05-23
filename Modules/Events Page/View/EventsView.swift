import Foundation
import SwiftUI
struct EventsView: View {
    @ObservedObject  var personalViewModel: EventsViewModel
    @Binding var user: UserInfo
    @State private var searchProperties: Set<String> = []
    @State var fullAcсess: Bool
    @State var free: Bool = false
    @State var today: Bool = false
    @State var tomorrow: Bool = false
    var body: some View {
            VStack {
                VStack(alignment: .leading) {
                    SearchBar(searchText: "Найди своё мероприятие", isSearching: false)
                        .padding(.top, 5)
                        .padding(.bottom, 8)
                    ScrollView(.horizontal) {
                        HStack(spacing: 20) {
                            CustomButton(searchProperties: $searchProperties, text: "Бесплатно", width: 100, height: 5)
                                .onTapGesture {
                                    self.free.toggle()
                                }
                            CustomButton(searchProperties: $searchProperties, text: "Сегодня", width: 100, height: 5)
                                .onTapGesture {
                                    self.today.toggle()
                                }
                            CustomButton(searchProperties: $searchProperties, text: "Завтра", width: 70, height: 5)
                                .onTapGesture {
                                    self.tomorrow.toggle()
                                }
                        }

                    }.padding(.leading, 20)
                        .padding(.bottom, 8)
                    ScrollView {
                        ForEach($personalViewModel.allEvents) { item in
                            EventCell(info: item, people: $user, fullAcсess: fullAcсess, canEdit: false, eventCellView: FavoriteViewModel(service: personalViewModel.service))
                        }
                    }
                }
                Spacer()

                Spacer()
            }
        
    }
    
    
    func choosData(data: EventModel) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"

        let day = dateFormatter.string(from: data.data)
        let tommorow = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: -1, to: Date())!)
        let toDay = dateFormatter.string(from: Date())
        print(toDay)
        print(day)
        print(tommorow)
    
        if today {
            if day != toDay {
                return false
            }
        } else if tomorrow {
            if tomorrow != today {
                return false
            }
        }
        return true
    }
}
