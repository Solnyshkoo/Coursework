import Foundation
import SwiftUI
struct VerificationView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var data: VerificationModel = .init()
    var body: some View {
        NavigationView {
            VStack {
                Text("Верификация").fontWeight(.heavy).font(.largeTitle).padding(.top, -30)
                    .padding(.bottom, 20)
                
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 20) {
                        ClassicTextField(labelText: "ФИО", fieldText: "Напишите ФИО как в паспорте", user: $data.FIO)
                        ClassicTextField(labelText: "Дата рождения", fieldText: "Напишите дату рождения как в паспорте", user: $data.birth)
                    
                        HStack(alignment: .center, spacing: 20) {
                            ClassicTextField(labelText: "Серия паспорта", fieldText: "Напишите серию", user: $data.series)
                            ClassicTextField(labelText: "Номер паспорта", fieldText: "Напишите номер ", user: $data.number)
                        }
                    }
                    
                }.padding()
                    .padding(.top, 60)
           
                HStack(alignment: .center, spacing: 20) {
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
                    // .padding(.trailing, 10)
                    
                    Button(action: {
                        // TODO: - подробнее
                    }) {
                        Text("Проверить").font(Font.system(size: 20, design: .default))
                            .padding(.trailing, 3)
                            .frame(width: 160, height: 20)
                    }.foregroundColor(ColorPalette.buttonText)
                        .padding()
                        .background(ColorPalette.acсentColor)
                        .cornerRadius(10)
                }.padding(.top, 50)
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

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VerificationView()
            VerificationView()
                .preferredColorScheme(.dark)
        }
    }
}
