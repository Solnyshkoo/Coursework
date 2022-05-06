import Foundation
import SwiftUI
struct NewEventView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var event = EventModel()
    
    var body: some View {
        VStack {
            NavigationView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    EventTextField(text: $event.name, title: "Название", subtitile: "In Tusa", width: 35)
                    EventTextField(text: $event.description, title: "Описание", subtitile: "Расскажи, что там будет..", width: 100)
                    EventTextField(text: $event.distination, title: "Местоположение", subtitile: "Адрес", width: 35)
                    EventTextField(text: $event.data, title: "Дата", subtitile: "Когда пир?", width: 35)
                    EventTextField(text: $event.price, title: "Стоимость входа в рублях", subtitile: "0, если бесплатно", width: 35)
                    EventTextField(text: $event.contacts, title: "Контакты", subtitile: "И как к вам записаться?", width: 60)
                    Spacer()
                }
               
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

struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NewEventView()
            NewEventView()
                .preferredColorScheme(.dark)
        }
    }
}
