import Foundation
import SwiftUI
struct ReviewView: View {
    @ObservedObject  var eventDetailViewModel: EventDetailViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var text: String = ""
    var body: some View {
        VStack {
            Text("Напишите отзыв")
                .foregroundColor(ColorPalette.text).font(.title2)
                .bold()
                .padding(.trailing, 10)
                .padding(.bottom, 15)
                .padding(.top, 15)
            EventTextField(text: $text, title: "", subtitile: "Что вы думаете о мероприятии?", width: 500)
            HStack(alignment: .center, spacing: 20, content: {
                Button(action: {
                   
                    self.mode.wrappedValue.dismiss()
                }) {
                    Text("Отменить").font(Font.system(size: 20, design: .default))
                        .padding(.trailing, 3)
                        .frame(width: 160, height: 20)
                }.foregroundColor(ColorPalette.buttonText)
                    .padding()
                    .background(ColorPalette.secondBackground)
                    .cornerRadius(10)
                   
                
                Button(action: {
                    eventDetailViewModel.addReview(text: text)
                    if eventDetailViewModel.review {
                        self.mode.wrappedValue.dismiss()
                    }
                   
                }) {
                    Text("Сохранить").font(Font.system(size: 20, design: .default))
                        .padding(.trailing, 3)
                        .frame(width: 160, height: 20)
                }.foregroundColor(ColorPalette.buttonText)
                    .padding()
                    .background(ColorPalette.acсentColor)
                    .cornerRadius(10)
                    .alert("К сожалению, не получилось сохранить комментарий.", isPresented: $eventDetailViewModel.warningReview) {
                            Button("OK", role: .cancel) { }
                     }
                   
                  //  .padding(.trailing, 10)
            }).padding(.top, 12)
            Spacer()
        }
    }
}

//struct ReviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForEach(ColorScheme.allCases, id: \.self) {
//            ReviewView().preferredColorScheme($0)
//        }
//    }
//}
