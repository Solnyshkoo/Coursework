import Foundation
import SwiftUI
import UIKit
struct FavoriteCell: View {
    @State var event = EventModel(id: 1, name: "moscow.malina", logo: Image("logo"), mainPhoto: Image("logo"), distination: "16 км", price: "1000", description: "Очередная очень крутая тусовка, где будут все твои друзья с потока и самые-самые развлечения. Ах да, там будет фонк и даже дабстеп, так что надо что то написать, чтобы протестить", participant: 10, like: false, data: "34 марта")
    @State var people: UserInfo
    @State private var heart = false
    var body: some View {
        HStack(alignment: .top) {
            event.mainPhoto
                .mediumRectangleCropped()
                
               
             //   .aspectRatio(contentMode: .fill)
                .shadow(color: ColorPalette.acсentColor, radius: 8)
                .padding(.trailing, 15)
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(event.name)
                        .font(.title2)
                        .padding(.top, 10)
                    Button(action: {
                        

                    }) {
                        Text("Подробнее")
                            .font(Font.system(size: 15, design: .default))
                            .fontWeight(.medium)
                            .tint( ColorPalette.text)
                            .padding([.top, .leading], 4)
                    }.foregroundColor(ColorPalette.acсentColor)
                        
                      
                }
                Spacer()
                Button(action: {
                    if people.favorities.contains(where: { $0.id == event.id }) {
                        people.favorities.remove(at:
                            people.favorities.firstIndex(where: { $0.id == event.id })!)
                    } else {
                        people.favorities.append(event)
                    }
                }) {
                    Image(systemName: people.favorities.contains(where: { $0.id == event.id }) ? "heart.fill" : "heart").font(Font.system(size: 20, design: .default)).padding(.top, 7)
                        .padding(.trailing, 1)
                }.foregroundColor(people.favorities.contains(where: { $0.id == event.id }) ? Color.red : ColorPalette.text)
            }
            Spacer()
        }.frame(height: 90)
            .padding()
    }
}

struct FavoriteCell_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCell(people: UserInfo())
    }
}
