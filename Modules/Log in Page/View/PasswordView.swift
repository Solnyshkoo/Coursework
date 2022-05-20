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
    @ObservedObject var passwordViewModel: LogInViewModel
    @State var title: String
    @State var twoPassword: Bool
    @State var man: UserInfo
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
                        if twoPassword {
                            if firstPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || man.password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty  {
                                warningText = "Заполните оба поля"
                            } else if firstPassword.trimmingCharacters(in: .whitespacesAndNewlines) != man.password.trimmingCharacters(in: .whitespacesAndNewlines) {
                                warningText = "Разные пароли"
                            } else {
                                warningText = ""
                                passwordViewModel.restorePassword(pass: firstPassword)
                            }
                        } else {
                            if man.nickname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || man.password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                warningText = "Заполните оба поля"
                            } else {
                                warningText = ""
                                passwordViewModel.registrateUser(respond: man) // TODO: alert
                            }
                        }
                    }) {
                        
                        Text("Продолжить").foregroundColor(ColorPalette.mainBackground).frame(width: UIScreen.main.bounds.width - 120).padding()
                   
                    }.disabled(man.password.isEmpty || (firstPassword.isEmpty && man.nickname.isEmpty))
                        .background(man.password.isEmpty || (firstPassword.isEmpty && man.nickname.isEmpty) ?
                            ColorPalette.disableButtom : ColorPalette.acсentColor)
                        .clipShape(Capsule())
                        .padding(.top, 45)
                        .onTapGesture(perform: {})
                        .fullScreenCover(isPresented: $passwordViewModel.showHome) { // TODO: если никнейм то вход
                            TabBar(people: $man, token: "", service: Service())
                            // AuthorizationView(output: passwordViewModel)
                        }
                        .alert(passwordViewModel.failRestoreText, isPresented: $passwordViewModel.showRestoreAlert) {
                            Button("OK", role: .cancel) { }
                        }
                        .alert(passwordViewModel.signUpFailed, isPresented: $passwordViewModel.showSignUpAlert) {
                            Button("OK", role: .cancel) { }
                        }
                }.padding(.bottom, 250)
                    .navigationBarTitleDisplayMode(.inline)
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
