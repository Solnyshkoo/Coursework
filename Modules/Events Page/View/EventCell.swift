import Foundation
import SwiftUI
struct EventCell: View {
    @Binding var info: EventModel
    @Binding var people: UserInfo
    @State var fullAcсess: Bool
    @State var canEdit: Bool
    @State var showAlert: Bool = false
    @State var showAlertLike: Bool = false
    @State var showParticipants: Bool = false
    @State var showDetailView: Bool = false
    @State var showPersonalView: Bool = false
    @State var showEditView: Bool = false
 
    @ObservedObject private var eventCellView: FavoriteViewModel = FavoriteViewModel(service: Service())
    var body: some View {
        // TODO: - шрифты
        VStack {
            VStack {
               HStack {
                   info.logo
                       .resizable()
                       .centerSquareCropped()
                       .clipShape(Circle())
                       .frame(width: 35, height: 35)
                       .scaledToFit()
                       .padding(.leading, 20)
                       .padding(.trailing, 15)
                   Text(info.creatorName).foregroundColor(ColorPalette.text).font(.title3)
                       .bold()
                       .padding(.trailing, 10)
                       .lineLimit(1)
                       .onTapGesture {
                           self.showPersonalView.toggle()
                       }
                       .fullScreenCover(isPresented: $showPersonalView) {
                           PersonalView(personalViewModel: PersonalViewModel(service: Service(), user: people), user: $people)
                       }
                       
                   Spacer()
                   if canEdit {
                       Button(action: {
                           self.showEditView.toggle()
                       }) {
                           Image(systemName: "pencil").font(Font.system(size: 25, design: .default)).padding(.top, 4)
                               .padding(.trailing, 10)
                       }.foregroundColor(ColorPalette.text)
                           .fullScreenCover(isPresented: $showEditView) {
                               EditEventView(editEventViewModel: EditEventViewModel(service: Service(), user: people, eventInfo: info), user: $people)
                           }
                   } else {
                   Button(action: {
                       if  fullAcсess {                           
                           if people.favorities.contains(where: { $0.id == info.id }) {
                               eventCellView.deleteFromFavorite(respond: info.id)
                               people.favorities.remove(at:
                                   people.favorities.firstIndex(where: { $0.id == info.id })!)
                               
                               if eventCellView.warningDelete {
                                   people.favorities.append(info)
                               }
                           } else {
                               people.favorities.append(info)
                               eventCellView.addEventToFavorite(respond: info.id)
                               if eventCellView.warning {
                                   people.favorities.remove(at:
                                       people.favorities.firstIndex(where: {$0.id == info.id })!)
                               }
                           }
                       } else {
                           self.showAlertLike.toggle()
                       }
                   }) {
                       Image(systemName: people.favorities.contains(where: { $0.id == info.id }) ? "heart.fill" : "heart").font(Font.system(size: 25, design: .default)).padding(.top, 4)
                           .padding(.trailing, 10)
                   }.foregroundColor(people.favorities.contains(where: { $0.id == info.id }) ? Color.red : ColorPalette.text)
                       .alert("Чтобы использовать эту функцию, вам надо зарегистрироваться.", isPresented: $showAlertLike) {
                               Button("OK", role: .cancel) { }
                       }
                       .alert("К сожалению, не получилось добавить мероприятие в избранное.", isPresented: $eventCellView.warning) {
                               Button("OK", role: .cancel) { }
                        }
                       .alert("К сожалению, не получилось удалить мероприятие из избранное.", isPresented: $eventCellView.warningDelete) {
                               Button("OK", role: .cancel) { }
                        }
                   }
                       
               }.padding(.bottom, 5)
            
                info.mainPhoto.resizable().smallRectangleCropped()
                    .frame(height: 500)
                // TODO: - поменять от вас
                HStack {
                    Text(info.name).font(.title)
                            .bold()
                        .foregroundColor(ColorPalette.text)
                        .padding(.leading, 10)
                        
                        Spacer()
                    HStack {
                        Text(info.data, style: .date).font(.callout).bold().padding(.trailing, 10)
                        Text(info.price + "₽").font(.callout).bold().padding(.trailing, 10)
                      
                    }
                }  .padding(.top, 2)
                // TODO: - кнопка ещё
             
                VStack(alignment: .leading) {
                    HStack {
                    Text(info.description)
                        .foregroundColor(ColorPalette.text)
                        .font(.callout)
                        .padding(.leading, 10)

                        .padding(.top, 1)
                        .lineLimit(3)
                        Spacer()
                    }
                }
                HStack {
                    Text(info.participant == 0 ? "" : String(info.participant) + " уже идут").font(.title3).underline().italic().padding(.leading, 20) .padding(.top, -5)
                        .onTapGesture {
                            self.showParticipants.toggle()
                        }
                        .fullScreenCover(isPresented: $showParticipants) {
                            ParticipantsView(participantsViewModel: ParticipantsViewModel(service: eventCellView.service, visitors: info.visitors))
                        }
                         Spacer()
                    Button(action: {
                        // TODO: - подробнее
                        if  fullAcсess {
                            self.showDetailView.toggle()
                        } else {
                            self.showAlert.toggle()
                        }
                    }) {
                        Text("Подробнее").font(Font.system(size: 18, design: .default)).padding(.top, 0)
                            .padding(.trailing, 3)
                            .frame(width: 110, height: 8)
                    }.foregroundColor(ColorPalette.buttonText)
                        .padding()
                        .background(ColorPalette.acсentColor)
                        .cornerRadius(10)
                        .padding(.top, 6)
                        .padding(.trailing, 10)
                        .alert("Чтобы использовать эту функцию, вам надо зарегистрироваться.", isPresented: $showAlert) {
                                Button("OK", role: .cancel) { }
                         }
                        .fullScreenCover(isPresented: $showDetailView) {
                            EventDetailView(eventDetailViewModel: EventDetailViewModel(service: eventCellView.service, id: info.id), user: $people)
                        }
                }
                Spacer()
            }
        }
    }
}


