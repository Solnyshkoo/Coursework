import Foundation
import SwiftUI
struct VerificationView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var verificationViewModel: VerificationViewModel
    @Binding var user: UserInfo
    @State private var data: VerificationModel = .init()
    @State var showInfo: Bool = false
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
                        data = VerificationModel()
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
                        verificationViewModel.checkPassport(data: data)
                        if verificationViewModel.dataIsCorrect {
                            user.validate = true
                        }
                    }) {
                        Text("Проверить").font(Font.system(size: 20, design: .default))
                            .padding(.trailing, 3)
                            .frame(width: 160, height: 20)
                    }.foregroundColor(ColorPalette.buttonText)
                        .padding()
                        .background(ColorPalette.acсentColor)
                        .cornerRadius(10)
                        .alert(verificationViewModel.textWarning, isPresented: $verificationViewModel.showWarning) {
                            Button("OK", role: .cancel) { }
                        }
                        .alert("Данные отправлены. Длительность проверки до недели", isPresented: $verificationViewModel.dataIsCorrect) {
                            Button("OK", role: .cancel) { }
                        }
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
