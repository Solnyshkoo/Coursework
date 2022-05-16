import Foundation
import SwiftUI
struct EventDetailView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var info: EventModel = .init(id: 1, name: "reading.club", logo: Image("logoRead"), mainPhoto: Image("photoRead"), distination: "Красная площадь", price: "100", description: "Привет! Мы приглашаем тебе на посиделки в антикафе. Обсудим книги, поделимся впечатлениемя. И да, каждого ждёт сюрприз", participant: 5, like: false, data: "20.05.2022", contacts: "Пишите kepetrova@edu.hse.ru")
    @State var people: UserInfo = .init()
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                VStack(alignment: .leading, spacing: 8, content:  {
                    info.mainPhoto.resizable().smallRectangleCropped()
                        .frame(height: 500)
                    // TODO: - кнопка ещё
                    Text(info.description)
                        .foregroundColor(ColorPalette.text)
                      //  .font(.subheadline)
                        .font(Font.system(size: 18, design: .default))
                        .padding(.top, 2)
                        .lineLimit(3)
                        .padding(.leading, 15)
                    
                    Text("Адрес: " + info.distination)
                        .font(Font.system(size: 18, design: .default))
                        .bold()
                        .padding(.leading, 15)
                    
                    Text("Дата: " + info.data)
                        .font(Font.system(size: 18, design: .default))
                        .bold()
                        .padding(.leading, 15)
                    Text("Стоимость: " + info.price + "₽")
                        .font(Font.system(size: 18, design: .default))
                        .bold()
                        .padding(.leading, 15)
                    Text("Контакты: " + info.contacts)
                        .font(Font.system(size: 18, design: .default))
                        .bold()
                        .padding(.leading, 15)
                    HStack {
                        Text(String(info.participant) + " уже идут").font(.title3).underline().italic().padding(.leading, 20).padding(.top)
                        Spacer()
                        Button(action: {
                            // TODO: - подробнее
                        }) {
                            Text("Пойду! ").font(Font.system(size: 18, design: .default)).padding(.top, 0)
                                .padding(.trailing, 3)
                                .frame(width: 110, height: 8)
                        }.foregroundColor(ColorPalette.buttonText)
                            .padding()
                            .background(ColorPalette.acсentColor)
                            .cornerRadius(10)
                            .padding(.top, 6)
                            .padding(.trailing, 20)
                      
                    }
                    Spacer()
                })
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
       
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
                
                        }).padding(.bottom, 5)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        VStack(alignment: .trailing, content: {
                            Button(action: {
                                if people.favorities.contains(where: { $0.id == info.id }) {
                                    people.favorities.remove(at:
                                        people.favorities.firstIndex(where: { $0.id == info.id })!)
                                } else {
                                    people.favorities.append(info)
                                }
                            }) {
                                Image(systemName: people.favorities.contains(where: { $0.id == info.id }) ? "heart.fill" : "heart").font(Font.system(size: 22, design: .default))
                            }.foregroundColor(people.favorities.contains(where: { $0.id == info.id }) ? Color.red : ColorPalette.text)
                        }).padding(.top, -2)
                    }
                })
            }
            }
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
