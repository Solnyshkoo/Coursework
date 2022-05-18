import Foundation
import SwiftUI
struct EventCell: View {
    @State var info: EventModel
    @State var people: UserInfo = UserInfo()
    @State var fullAcсess: Bool
    @State var showAlert: Bool = false
    @State var showAlertLike: Bool = false
    @State var showParticipants: Bool = false
    @State var showDetailView: Bool = false
    @State var showPersonalView: Bool = false
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
                   Text(info.name).foregroundColor(ColorPalette.text).font(.title3)
                       .bold()
                       .padding(.trailing, 10)
                       .lineLimit(1)
                       .onTapGesture {
                           self.showPersonalView.toggle()
                       }
                       .fullScreenCover(isPresented: $showPersonalView) {
                           PersonalView(output: PersonalViewModel(service: Service(), tok: ""))
                       }
                       
                   Spacer()
                   Button(action: {
                       if  fullAcсess {
                           if people.favorities.contains(where: { $0.id == info.id }) {
                               people.favorities.remove(at:
                                   people.favorities.firstIndex(where: { $0.id == info.id })!)
                           } else {
                               people.favorities.append(info)
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
               }.padding(.bottom, 5)
            
                info.mainPhoto.resizable().smallRectangleCropped()
                    .frame(height: 500)
                   
                
                // TODO: - поменять от вас
                HStack {
                    Text(info.price + "₽").font(.title3).bold().padding(.leading, 10)
                    Spacer()
                    Text(info.data).font(.title3).bold().padding(.trailing, 10)
                }
                // TODO: - кнопка ещё
                Text(info.description)
                    .foregroundColor(ColorPalette.text)
                    .font(.callout)
                    .padding(.leading, 10)
                    
                    .padding(.top, 2)
                    .lineLimit(3)
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


struct EventCellPreviewContainer_2: View {
    @State var lol: EventModel = EventModel(id: 1, name: "moscow.malina", logo: Image("logo"), mainPhoto: Image("photo"), distination: "16 км", price: "1000", description: "Очередная очень крутая тусовка, где будут все твои друзья с потока и самые-самые развлечения. Ах да, там будет фонк и даже дабстеп, так что надо что то написать, чтобы протестить", participant: 10, like: false, data: "34 марта")

    var body: some View {
        EventCell(info: lol, fullAcсess: true)
    }
}

struct EventCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EventCellPreviewContainer_2()
                .preferredColorScheme(.dark)
            EventCellPreviewContainer_2()
                .preferredColorScheme(.light)
        }
    }
}

