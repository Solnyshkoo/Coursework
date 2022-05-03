import Foundation
import SwiftUI
struct EventCell: View {
    @State var info: EventModel
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
                   Spacer()
                   Button(action: {
                       // TODO: - лайк
                   }) {
                       Image(systemName: info.like ? "heart.fill" : "heart").font(Font.system(size: 25, design: .default)).padding(.top, 4)
                           .padding(.trailing, 10)
                   }.foregroundColor(info.like ? Color.red : ColorPalette.text)
               }.padding(.bottom, 5)
            
                    info.mainPhoto.resizable().smallRectangleCropped()
                    .frame(height: 500)
                   
                
                // TODO: - поменять от вас
                HStack {
                    Text(info.distination + " от вас  ·  " + info.price + "₽").font(.title3).bold().padding(.leading, 10)
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
                    Text(String(info.participant) + " уже идут").font(.title3).bold().padding(.leading, 10) .padding(.top, 10)
                         Spacer()
                    Button(action: {
                        // TODO: - подробнее
                    }) {
                        Text("Подробнее").font(Font.system(size: 18, design: .default)).padding(.top, 4)
                            .padding(.trailing, 10)
                            .frame(width: 110, height: 10)
                    }.foregroundColor(ColorPalette.buttonText)
                        .padding()
                        .background(ColorPalette.acсentColor)
                        .cornerRadius(10)
                        .padding(.top, 7)
                        .padding(.trailing, 10)
                }
                Spacer()
            }
        }
    }
}


struct EventCellPreviewContainer_2: View {
    @State var lol: EventModel = EventModel(id: 1, name: "moscow.malina", logo: Image("logo"), mainPhoto: Image("photo"), distination: "16 км", price: "1000", description: "Очередная очень крутая тусовка, где будут все твои друзья с потока и самые-самые развлечения. Ах да, там будет фонк и даже дабстеп, так что надо что то написать, чтобы протестить", participant: 10, like: false, data: "34 марта")

    var body: some View {
        EventCell(info: lol)
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

