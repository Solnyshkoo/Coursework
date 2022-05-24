import Foundation
import SwiftUI
struct EventDetailView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var eventDetailViewModel: EventDetailViewModel
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
                    Text(eventDetailViewModel.info.description)
                        .foregroundColor(ColorPalette.text)
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
                                        ReviewView(eventDetailViewModel: eventDetailViewModel)
                                    }
                            } else {
                              
                                Spacer()
                                Button(action: {
                                    
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
                                if user.subscribes.contains(where: { $0.id ==  eventDetailViewModel.info.id }) {
                                    let index = user.subscribes.firstIndex(where: { $0.id ==  eventDetailViewModel.info.id })
                                    user.subscribes[index!].participant -= 1
                                    
                                    eventDetailViewModel.deleteFromGoingTo(respond: eventDetailViewModel.info.id)
                                    user.subscribes.remove(at:
                                    user.subscribes.firstIndex(where: { $0.id ==  eventDetailViewModel.info.id })!)
                                   
                                   // user.subscribes.first(where:
                                    
                                    if eventDetailViewModel.warningGoingDelete {
                                        let index = user.subscribes.firstIndex(where: { $0.id ==  eventDetailViewModel.info.id })
                                        user.subscribes[index!].participant += 1
                                        eventDetailViewModel.info.visitors.append(eventDetailViewModel.info.id)
                                    
                                        user.subscribes.append(eventDetailViewModel.info)
                                      
                                    }
                                    eventDetailViewModel.getEventInfo()
                                } else {
                                   
                                    eventDetailViewModel.addEventToGoingTo(respond: eventDetailViewModel.info.id)
                                    eventDetailViewModel.info.visitors.append(eventDetailViewModel.info.id)
                                    user.subscribes.append( eventDetailViewModel.info)
                                    let index = user.subscribes.firstIndex(where: { $0.id ==  eventDetailViewModel.info.id })
                                    user.subscribes[index!].participant += 1
                                    
                                    if eventDetailViewModel.warningGoing {
                                        let index = user.subscribes.firstIndex(where: { $0.id ==  eventDetailViewModel.info.id })
                                        user.subscribes[index!].participant -= 1
                                        eventDetailViewModel.info.visitors.remove(at: eventDetailViewModel.info.visitors.first(where: { $0 == eventDetailViewModel.info.id })!)
                                        
                                        user.subscribes.remove(at:
                                        user.subscribes.firstIndex(where: { $0.id ==  eventDetailViewModel.info.id })!)
                                       
                                    }
                                    eventDetailViewModel.getEventInfo()
                                }
                            }) {
                                Text(user.subscribes.contains(where: { $0.id == eventDetailViewModel.info.id }) ? " Уже иду" : "Пойду! ").font(Font.system(size: 18, design: .default)).padding(.top, 0)
                                    .padding(.trailing, 3)
                                    .frame(width: 110, height: 8)
                            }.foregroundColor(ColorPalette.buttonText)
                                .padding()
                                .background(ColorPalette.acсentColor)
                                .cornerRadius(10)
                                .padding(.top, 6)
                                .padding(.trailing, 20)
                                .alert("К сожалению, не получилось записаться на мероприятие.", isPresented: $eventDetailViewModel.warningGoing) {
                                        Button("OK", role: .cancel) { }
                                 }
                                .alert("К сожалению, не получилось отписаться от мероприятия.", isPresented: $eventDetailViewModel.warningGoingDelete) {
                                        Button("OK", role: .cancel) { }
                                 }
                        }
                      
                      
                    }
                   
                    Text("")
             
                    Divider()
                    // TODO: отзывы цикл
                    ForEach(eventDetailViewModel.info.comments) { item in
                        ReviewCell(info: item)
                            .swipeActions {
                                    Button {
                                        eventDetailViewModel.deleteReview(id: item.id)
                                        if eventDetailViewModel.reviewDelete {
                                            eventDetailViewModel.info.comments.remove(at:  eventDetailViewModel.info.comments.firstIndex(where: { $0.id == item.id })!)
                                        }
                                    } label: {
                                            Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.red)
                            }
                    }
                    .alert("К сожалению, не получилось удалить комментарий.", isPresented: $eventDetailViewModel.reviewDelete) {
                            Button("OK", role: .cancel) { }
                     }

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
                                    eventDetailViewModel.deleteFromFavorite(respond: eventDetailViewModel.info.id)
                                       if eventDetailViewModel.warningDelete {
                                           user.favorities.append(eventDetailViewModel.info)
                                       }
                                } else {
                                    user.favorities.append(eventDetailViewModel.info)
                                    eventDetailViewModel.addEventToFavorite(respond: eventDetailViewModel.info.id)
                                     if eventDetailViewModel.warning {
                                         user.favorities.remove(at:
                                                                    user.favorities.firstIndex(where: {$0.id == eventDetailViewModel.info.id })!)
                                     }
                                }
                            }) {
                                Image(systemName:
                                        user.favorities.contains(where: { $0.id == eventDetailViewModel.info.id }) ? "heart.fill" : "heart").font(Font.system(size: 22, design: .default))
                            }.foregroundColor(user.favorities.contains(where: { $0.id == eventDetailViewModel.info.id }) ? Color.red : ColorPalette.text)
                                .alert("К сожалению, не получилось добавить мероприятие в избранное.", isPresented: $eventDetailViewModel.warning) {
                                        Button("OK", role: .cancel) { }
                                 }
                                .alert("К сожалению, не получилось удалить мероприятие из избранношл.", isPresented: $eventDetailViewModel.warningDelete) {
                                        Button("OK", role: .cancel) { }
                                 }
                        }).padding(.top, -2)
                    }
                })
            }
            }
        }
    }
}
