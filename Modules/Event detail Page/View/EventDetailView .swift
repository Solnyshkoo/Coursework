import Foundation
import SwiftUI
struct EventDetailView : View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var info: EventModel = EventModel(id: 1, name: "reading.club", logo: Image("logoRead"), mainPhoto: Image("photoRead"), distination: "", price: "100", description: "Привет! Мы приглашаем тебе на посиделки в антикафе. Обсудим книги, поделимся впечатлениемя. И да, каждого ждёт сюрприз", participant: 5, like: false, data: "20.05.2022", contacts: "")
    @State var people: UserInfo = UserInfo()
    var body: some View {
        VStack {
            NavigationView {
            VStack {
               
            
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
                    Text(String(info.participant) + " уже идут").font(.title3).underline().italic().padding(.leading, 20) .padding(.top, -5)
                         Spacer()
                    Button(action: {
                        // TODO: - подробнее
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
                }
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .navigation) {
                    HStack(alignment: .center, content: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(ColorPalette.navigationBarItem)
                            .onTapGesture {
                                self.mode.wrappedValue.dismiss()
                            }
                        
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
//                        VStack(alignment: .trailing, spacing: 10, content: {
//                        Button(action: {
//                            if people.favorities.contains(where: { $0.id == info.id }) {
//                                people.favorities.remove(at:
//                                    people.favorities.firstIndex(where: { $0.id == info.id })!)
//                            } else {
//                                people.favorities.append(info)
//                            }
//                        }) {
//                            Image(systemName: people.favorities.contains(where: { $0.id == info.id }) ? "heart.fill" : "heart").font(Font.system(size: 22, design: .default))
//
//                                .padding(.trailing, 10)
//                        }.foregroundColor(people.favorities.contains(where: { $0.id == info.id }) ? Color.red : ColorPalette.text)
//                        })
                    }).padding(.bottom, 5)
                  
                }
               
            })
                Spacer()
            }
            Spacer()
        }
    
    }
}
struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            EventDetailView().preferredColorScheme($0)
        }
    }
}
