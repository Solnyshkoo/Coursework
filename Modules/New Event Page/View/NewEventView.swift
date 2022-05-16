import Foundation
import SwiftUI
struct NewEventView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var event = EventModel()
    @State private var shoosePhoto = false
    @State private var photo: Image?
    
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                    Text("Новое событие").fontWeight(.heavy).font(.largeTitle).padding(.top, -30)
                        .padding(.bottom, 20)
                    HStack(alignment: .center) {
                        Circle()
                            .frame(width: 150, height: 150)
                            .foregroundColor(ColorPalette.secondBackground)
                            .overlay {
                            Image(systemName: "camera").resizable().frame(width: 80, height: 60)
                                .onTapGesture {
                                    shoosePhoto.toggle()
                                }
                               
                                }.foregroundColor(ColorPalette.lightGray2)
                            .sheet(isPresented: $shoosePhoto) {
                                ImagePicker(image: $photo, isPresented: $shoosePhoto)
                        }
                    }
                    .padding(.bottom, 15)
                VStack(alignment: .leading, spacing: 20) {
                    EventTextField(text: $event.name, title: "Название", subtitile: "Название", width: 40)
                    EventTextField(text: $event.description, title: "Описание", subtitile: "Расскажи, что там будет..", width: 100)
                    EventTextField(text: $event.distination, title: "Местоположение", subtitile: "Адрес", width: 40)
                    EventTextField(text: $event.data, title: "Дата", subtitile: "Когда?", width: 40)
                    EventTextField(text: $event.price, title: "Стоимость входа в рублях", subtitile: "0, если бесплатно", width: 40)
                    EventTextField(text: $event.contacts, title: "Контакты", subtitile: "И как к вам записаться?", width: 60)
                    Divider()
                    
                }
                    HStack(alignment: .center, spacing: 20, content: {
                        Button(action: {
                            // TODO: - подробнее
                        }) {
                            Text("Отменить").font(Font.system(size: 20, design: .default))
                                .padding(.trailing, 3)
                                .frame(width: 160, height: 20)
                        }.foregroundColor(ColorPalette.buttonText)
                            .padding()
                            .background(ColorPalette.secondBackground)
                            .cornerRadius(10)
                           // .padding(.top, 10)
                            //.padding(.trailing, 10)
                        
                        Button(action: {
                            // TODO: - подробнее
                        }) {
                            Text("Создать").font(Font.system(size: 20, design: .default))
                                .padding(.trailing, 3)
                                .frame(width: 160, height: 20)
                        }.foregroundColor(ColorPalette.buttonText)
                            .padding()
                            .background(ColorPalette.acсentColor)
                            .cornerRadius(10)
                           
                          //  .padding(.trailing, 10)
                    }).padding(.top, 12)
                    Spacer()
                .navigationBarBackButtonHidden(true)
                .toolbar(content: {
                    ToolbarItem(placement: .navigation) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(ColorPalette.navigationBarItem)
                            .onTapGesture {
                                self.mode.wrappedValue.dismiss()
                            }
                    }
                })
                }
            }
           
            
        }
    }
}

struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NewEventView()
            NewEventView()
                .preferredColorScheme(.dark)
        }
    }
}
