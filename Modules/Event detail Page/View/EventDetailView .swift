import Foundation
import SwiftUI
struct EventDetailView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var info: EventModel = .init(id: 1, name: "reading.club", logo: Image("logoRead"), mainPhoto: Image("photoRead"), distination: "Красная площадь", price: "100", description: "Привет! Мы приглашаем тебе на посиделки в антикафе. Обсудим книги, поделимся впечатлениемя. И да, каждого ждёт сюрприз", participant: 5, like: false, data: Date(), contacts: "Пишите kepetrova@edu.hse.ru")
    @State var people: UserInfo = .init()
    @State var showParticipants: Bool = false
    @State var showPersonalView: Bool = false
    @State var alreadyGo: Bool = true
    @State var passed: Bool = true
    @State var showReview: Bool = false
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
                    HStack {
                    Text("Дата: ")
                        .font(Font.system(size: 18, design: .default))
                        .bold()
                        .padding(.leading, 15)
                        Text(info.data, style: .date)
                            .font(Font.system(size: 18, design: .default))
                            .bold()
                            .padding(.leading, 2)
                        Text(info.data, style: .time)
                            .font(Font.system(size: 18, design: .default))
                            .bold()
                            .padding(.leading, 2)
                        Spacer()
                    }
                    Text("Стоимость: " + info.price + "₽")
                        .font(Font.system(size: 18, design: .default))
                        .bold()
                        .padding(.leading, 15)
                    Text("Контакты: " + info.contacts)
                        .font(Font.system(size: 18, design: .default))
                        .bold()
                        .padding(.leading, 15)
                    HStack {
                      
                        
                        if passed {
                            Text(info.participant == 0 ? "" : String(info.participant) + " было").font(.title3).underline().italic().padding(.leading, 20).padding(.top)
                                .onTapGesture {
                                    self.showParticipants.toggle()
                                }
                                .fullScreenCover(isPresented: $showParticipants) {
                                   ParticipantsView()
                                }
                            Spacer()
                            if alreadyGo {
                                Button(action: {
                                    self.showReview.toggle()
                                }) {
                                    Text("Написать отзыв").font(Font.system(size: 18, design: .default)).padding(.top, 0)
                                        .padding(.trailing, 3)
                                        .lineLimit(3)
                                        .frame(width: 140, height: 8)
                                }.foregroundColor(ColorPalette.buttonText)
                                    .padding()
                                    .background(ColorPalette.acсentColor)
                                    .cornerRadius(10)
                                    .padding(.top, 6)
                                    .padding(.trailing, 20)
                                    .sheet(isPresented: $showReview) {
                                        ReviewView()
                                    }
                            } else {
                                Text(info.participant == 0 ? "" : String(info.participant) + " уже идут").font(.title3).underline().italic().padding(.leading, 20).padding(.top)
                                    .onTapGesture {
                                        self.showParticipants.toggle()
                                    }
                                    .fullScreenCover(isPresented: $showParticipants) {
                                       ParticipantsView()
                                    }
                                Spacer()
                                Button(action: {
                                    // TODO: - подробнее
                                }) {
                                    Text("Прошло").font(Font.system(size: 18, design: .default)).padding(.top, 0)
                                        .padding(.trailing, 3)
                                        .frame(width: 110, height: 8)
                                }.foregroundColor(ColorPalette.buttonText)
                                    .padding()
                                    .background(ColorPalette.disableButtom)
                                    .cornerRadius(10)
                                    .padding(.top, 6)
                                    .padding(.trailing, 20)
                            }
                        } else {
                            Button(action: {
                                // TODO: - подробнее
                            }) {
                                Text(alreadyGo ? "Иду" : "Пойду! ").font(Font.system(size: 18, design: .default)).padding(.top, 0)
                                    .padding(.trailing, 3)
                                    .frame(width: 110, height: 8)
                            }.foregroundColor(ColorPalette.buttonText)
                                .padding()
                                .background(ColorPalette.acсentColor)
                                .cornerRadius(10)
                                .padding(.top, 6)
                                .padding(.trailing, 20)
                        }
                      
                      
                    }
                   
                    Text("")
             
                    Divider()
                    // TODO: отзывы цикл
                    ReviewCell(info: ReviewModel(userName: "Петрова Ксения ", logo: Image("logo"), nickname: "ksu", review: "Прекрасное мероприятие. Очень понравилось, жаль, что мне надо было спешить и не смогла посидеть дольше. Очень жду следующего события!"))
                    //Spacer()
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
                                Image(systemName:
                                        people.favorities.contains(where: { $0.id == info.id }) ? "heart.fill" : "heart").font(Font.system(size: 22, design: .default))
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
