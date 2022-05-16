import Foundation
import SwiftUI

protocol PasswordViewProtocolOutput {
    func registrateUser(respond: UserInfo) -> Bool
    func getWarning() -> String
    func getServicApi() -> Service
    func getTokenUser() -> String
}
struct PasswordView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var passwordViewModel: LogInViewModel
    @State var title: String
    @State var twoPassword: Bool
    @State var man: UserInfo
    @State private var showingMainView = false
    @State private var alert = false
    @State var firstPassword = ""
    @State private var warningText = " "
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    VStack {
                        Text(title).fontWeight(.heavy).font(.largeTitle).padding([.top, .bottom], 40)
                        VStack(alignment: .leading) {
                            if self.twoPassword {
                                SecretTextField(labelText: "Пароль", fieldText: "Введите пароль", pass: $firstPassword).padding(.bottom, 20)
                            } else {
                                ClassicTextField(labelText: "Nickname", fieldText: "Введите nickname", user: $man.nickname).padding(.bottom, 20)
                            }
                            SecretTextField(labelText: (twoPassword ? "Повторите " : "") + " Пароль", fieldText: "Введите пароль" + (twoPassword ? " ещё раз" : ""), pass: $man.password).padding(.bottom, 20)
                        }.padding(.horizontal, 6)
                    }.padding()
                    Text(warningText).font(Font.system(size: 12, design: .default)).padding([.top, .leading], 5).foregroundColor(ColorPalette.warningColor)
                    
                    Button(action: {
                        if !passwordViewModel.registrateUser(respond: man) {
                            warningText = passwordViewModel.getText()
                        } else if !twoPassword || firstPassword == man.password {
                            self.showingMainView.toggle()
                        } else {
                            warningText = "Passwords are different"
                            self.alert = true
                        }
                        
                    }) {
                        
                        Text("Продолжить").foregroundColor(ColorPalette.mainBackground).frame(width: UIScreen.main.bounds.width - 120).padding()
                   
                    }.disabled(man.password.isEmpty || (firstPassword.isEmpty && man.nickname.isEmpty))
                        .background(man.password.isEmpty || (firstPassword.isEmpty && man.nickname.isEmpty) ?
                            ColorPalette.disableButtom : ColorPalette.acсentColor)
                        .clipShape(Capsule())
                        .padding(.top, 45)
                        .onTapGesture(perform: {})
                        .fullScreenCover(isPresented: $showingMainView) { // TODO: если никнейм то вход
                            AuthorizationView(output: passwordViewModel)
                        }
                }.padding(.bottom, 250)
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
