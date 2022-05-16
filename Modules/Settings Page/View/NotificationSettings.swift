import Foundation
import SwiftUI
struct NotificationSettings: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var first: Bool = true
    @State var second: Bool = true

    var body: some View {
        NavigationView {
        Form {
            Section() {
                HStack {
                    Text("Уведомлять за три дня о мероприятии из избранном").padding([.bottom, .top], 5)
                        .padding(.trailing, 30)
                    Spacer()
                    if first {
                        Image("done")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 30, height: 30)
                            .foregroundColor(ColorPalette.text)
                    }
                }.onTapGesture {
                    self.first.toggle()
                }
//                    .fullScreenCover(isPresented: $showFavorite) {
//                        FavoriteView(people: $people)
//                    }
                
                HStack {
                    Text("Уведомлять за три дня о мероприятии, на которое я иду")
                        .padding([.bottom, .top], 5)
                        .padding(.trailing, 30)
                    Spacer()
                    if second {
                        Image("done")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 30, height: 30)
                            .foregroundColor(ColorPalette.text)
                    }
                }.onTapGesture {
                    self.second.toggle()
                }
//                    .fullScreenCover(isPresented: $showFavorite) {
//                        FavoriteView(people: $people)
//                    }
                
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .navigation) {
                HStack(alignment: .center, content: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(ColorPalette.navigationBarItem)
                        .onTapGesture {
                            self.mode.wrappedValue.dismiss()
                        }
                    Text("Уведомления").fontWeight(.heavy).font(.title)
                        .padding(.leading, 65)
                        .padding(.top, 18)
        
                }).padding(.bottom, 20)
                
            }                    })
        }
    }
}


struct NotificationSettings_Previews: PreviewProvider {
static var previews: some View {
    NotificationSettings()
        .preferredColorScheme(.dark)
}
}
