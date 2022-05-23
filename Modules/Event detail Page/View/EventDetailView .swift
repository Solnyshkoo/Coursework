import Foundation
import SwiftUI
struct EventDetailView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject  var eventDetailViewModel: EventDetailViewModel
    @Binding var user: UserInfo
    @State var showParticipants: Bool = false
    @State var showPersonalView: Bool = false
    @State var alreadyGo: Bool = false
    @State var passed: Bool = false
    @State var showReview: Bool = false
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                VStack(alignment: .leading, spacing: 8, content:  {
                    eventDetailViewModel.info.mainPhoto.resizable().smallRectangleCropped()
                        .frame(height: 500)
                    // TODO: - кнопка ещё
                    Text(eventDetailViewModel.info.description)
                        .foregroundColor(ColorPalette.text)
                      //  .font(.subheadline)
                        .font(Font.system(size: 18, design: .default))
                        .padding(.top, 2)
                        .lineLimit(3)
                        .padding(.leading, 15)
                    
                    Text("Адрес: " + eventDetailViewModel.info.distination)
                        .font(Font.system(size: 18, design: .default))
                        .bold()
                        .padding(.leading, 15)
                    HStack {
                    Text("Дата: ")
                        .font(Font.system(size: 18, design: .default))
                        .bold()
                        .padding(.leading, 15)
                        Text(eventDetailViewModel.info.data, style: .date)
                            .font(Font.system(size: 18, design: .default))
                            .bold()
                            .padding(.leading, 2)
                        Text(eventDetailViewModel.info.data, style: .time)
                            .font(Font.system(size: 18, design: .default))
                            .bold()
                            .padding(.leading, 2)
                        Spacer()
                    }
                    Text("Стоимость: " + eventDetailViewModel.info.price + "₽")
                        .font(Font.system(size: 18, design: .default))
                        .bold()
                        .padding(.leading, 15)
                    Text("Контакты: " + eventDetailViewModel.info.contacts)
                        .font(Font.system(size: 18, design: .default))
                        .bold()
                        .padding(.leading, 15)
                    HStack {
                      
                        
                        if eventDetailViewModel.info.passed {
                            Text(eventDetailViewModel.info.participant == 0 ? "" : String(eventDetailViewModel.info.participant) + " было").font(.title3).underline().italic().padding(.leading, 20).padding(.top)
                                .onTapGesture {
                                    self.showParticipants.toggle()
                                }
                                .fullScreenCover(isPresented: $showParticipants) {
                                    ParticipantsView(participantsViewModel: ParticipantsViewModel(service: eventDetailViewModel.service, visitors: eventDetailViewModel.info.visitors))
                                }
                            Spacer()
                            if user.subscribes.contains(where: { $0.id == eventDetailViewModel.info.id }) {
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
                            Text(eventDetailViewModel.info.participant == 0 ? "" : String(eventDetailViewModel.info.participant) + " уже идут").font(.title3).underline().italic().padding(.leading, 20).padding(.top)
                                .onTapGesture {
                                    self.showParticipants.toggle()
                                }
                                .fullScreenCover(isPresented: $showParticipants) {
                                    ParticipantsView(participantsViewModel: ParticipantsViewModel(service: eventDetailViewModel.service, visitors: eventDetailViewModel.info.visitors))
                                }
                            Spacer()
                            Button(action: {
                                // TODO: - подробнее
                            }) {
                                Text(user.subscribes.contains(where: { $0.id == eventDetailViewModel.info.id }) ? "Иду" : "Пойду! ").font(Font.system(size: 18, design: .default)).padding(.top, 0)
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
                    ForEach(eventDetailViewModel.info.comments) { item in
                        ReviewCell(info: item)
                    }
//                        .swipeActions(edge: .trailing) {
//                               Button(role: .destructive) {
//
//                                   //TODO:
//
//                               } label: {
//                                   Label("Delete", systemImage: "trash")
//                               }
//
//                           }
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
                        
                            eventDetailViewModel.info.logo
                                .resizable()
                                .centerSquareCropped()
                                .clipShape(Circle())
                                .frame(width: 35, height: 35)
                                .scaledToFit()
                                .padding(.leading, 20)
                                .padding(.trailing, 15)
                            Text(eventDetailViewModel.info.name).foregroundColor(ColorPalette.text).font(.title3)
                                .bold()
                                .padding(.trailing, 10)
                                .lineLimit(1)
                
                        }).padding(.bottom, 5)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        VStack(alignment: .trailing, content: {
                            Button(action: {
                                if user.favorities.contains(where: { $0.id == eventDetailViewModel.info.id }) {
                                    user.favorities.remove(at:
                                                            user.favorities.firstIndex(where: { $0.id == eventDetailViewModel.info.id })!)
                                } else {
                                    user.favorities.append(eventDetailViewModel.info)
                                }
                            }) {
                                Image(systemName:
                                        user.favorities.contains(where: { $0.id == eventDetailViewModel.info.id }) ? "heart.fill" : "heart").font(Font.system(size: 22, design: .default))
                            }.foregroundColor(user.favorities.contains(where: { $0.id == eventDetailViewModel.info.id }) ? Color.red : ColorPalette.text)
                        }).padding(.top, -2)
                    }
                })
            }
            }
        }
    }
}

//struct EventDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForEach(ColorScheme.allCases, id: \.self) {
//            EventDetailView().preferredColorScheme($0)
//        }
//    }
//}
