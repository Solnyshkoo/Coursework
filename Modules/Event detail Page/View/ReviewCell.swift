import Foundation
import SwiftUI
struct ReviewCell: View {
    @State var showDetailView: Bool = false
    @State var showPersonalView: Bool = false
    @State var info: ReviewModel
    var body: some View {
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
                   Text(info.nickname).foregroundColor(ColorPalette.text).font(.title3)
                       .bold()
                       .padding(.trailing, 10)
                       .lineLimit(1)
                       .onTapGesture {
                           self.showPersonalView.toggle()
                       }
                       .fullScreenCover(isPresented: $showPersonalView) {
//                           PersonalView(output: PersonalViewModel(service: Service(), user: people, newUser: false))
                       }
                   Spacer()
               }
                Text(info.review).padding([.leading, .trailing], 3)
            }
            Divider()
            
        }
    }
}

struct ReviewCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ReviewCell(info: ReviewModel(userName: "Петрова Ксения ", logo: Image("logo"), nickname: "ksu", review: "Прекрасное мероприятие. Очень понравилось, жаль, что мне надо было спешить и не смогла посидеть дольше. Очень жду следующего события!"))
                .preferredColorScheme(.dark)
            ReviewCell(info:  ReviewModel(userName: "Петрова Ксения ", logo: Image("logo"), nickname: "ksu", review: "Прекрасное мероприятие. Очень понравилось, жаль, что мне надо было спешить и не смогла посидеть дольше. Очень жду следующего события!"))
                .preferredColorScheme(.light)
        }
    }
}

