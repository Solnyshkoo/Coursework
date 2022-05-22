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
    @ObservedObject var eventCellView: FavoriteViewModel 
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
                           PersonalView(personalViewModel: PersonalViewModel(service: Service(), user: people, newUser: false), user: $people)
                       }
                       
                   Spacer()
                   if canEdit {
                       Button(action: {
                       
                           
                       }) {
                           Image(systemName:  "pencil" ).font(Font.system(size: 25, design: .default)).padding(.top, 4)
                               .padding(.trailing, 10)
                       }.foregroundColor(ColorPalette.text)
                   } else {
                   Button(action: {
                       if  fullAcсess {
                           if people.favorities.contains(where: { $0.id == info.id }) {
                               people.favorities.remove(at:
                                   people.favorities.firstIndex(where: { $0.id == info.id })!)
                           } else {
                               people.favorities.append(info)
                               eventCellView.addEventToFavorite(respond: info.id)
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
                        Text(" · " + info.price + "₽").font(.callout).bold().padding(.trailing, 10)
                        Spacer()
                    }
                   
                    
                    
                }  .padding(.top, 2)
                // TODO: - кнопка ещё
             
                VStack(alignment: .leading) {
                    Text(info.description)
                        .foregroundColor(ColorPalette.text)
                        .font(.callout)
                        .padding(.leading, 10)

                        .padding(.top, 1)
                        .lineLimit(3)
                }
                HStack {
                    Text(info.participant == 0 ? "" : String(info.participant) + " уже идут").font(.title3).underline().italic().padding(.leading, 20) .padding(.top, -5)
                        .onTapGesture {
                            self.showParticipants.toggle()
                        }
                        .fullScreenCover(isPresented: $showParticipants) {
                           ParticipantsView()
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
                            EventDetailView()
                        }
                            
                        
                }
                Spacer()
            }
        }
    }
}


//struct EventCellPreviewContainer_2: View {
//    @State var lol: EventModel = EventModel(id: 1, name: "Экватор", creatorName: "moscow.malina", logo: Image("logo"), mainPhoto: Image("photo"), distination: "16 км", price: "1000", description: "Очередная очень крутая тусовка, где будут все твои друзья с потока и самые-самые развлечения. Ах да, там будет фонк и даже дабстеп, так что надо что то написать, чтобы протестить", participant: 10, like: false, data: "34 марта")
//    @State var o = UserInfo()
//
//    var body: some View {
//        EventCell(info: $lol, people: $o, fullAcсess: true, canEdit: true), eventCellView: FavoriteViewModel(service: Service, user: <#T##UserInfo#>, newUser: <#T##Bool#>)
//    }
//}
//
//struct EventCell_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            EventCellPreviewContainer_2()
//                .preferredColorScheme(.dark)
//            EventCellPreviewContainer_2()
//                .preferredColorScheme(.light)
//        }
//    }
//}

