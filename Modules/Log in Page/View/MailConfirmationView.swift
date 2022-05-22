import Foundation
import SwiftUI

struct MailConfirmationView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var mailConfirmationViewModel: LogInViewModel
    @Binding var man: UserInfo
    @State var mail = ""
    @State var сoder = ""
    var restorePassword: Bool
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    VStack {
                        Text("Подтверждение").fontWeight(.heavy).font(.largeTitle).padding(.top, 35)
                        VStack(alignment: .leading) {
                            ClassicTextField(labelText: "Почта", fieldText: "Напишите почту", user: $man.mail).padding(.top, 20)
                        }.padding(.horizontal, 6)

                    }.padding()

                    VStack {
                        Button(action: {
                            if restorePassword {
                                mailConfirmationViewModel.verifyEmail(email: man.mail, nickname: man.nickname)
                                if  !mailConfirmationViewModel.emailUser {
                                    mailConfirmationViewModel.sendCodeToEmail(email: man.mail)
                                }
                            } else {
                                mailConfirmationViewModel.sendCodeToEmail(email: man.mail)
                            }
                            
                        }) {
                            Text("Отправить код").foregroundColor(ColorPalette.buttonText).frame(width: UIScreen.main.bounds.width - 120).padding()
                        }.disabled(man.mail.isEmpty)
                            .background(man.mail.isEmpty ? ColorPalette.disableButtom : ColorPalette.acсentColor)
                            .clipShape(Capsule())
                            .padding(.top, 20).padding(.top, 10)
                    }.alert(mailConfirmationViewModel.wrongMail, isPresented: $mailConfirmationViewModel.showAllert) {
                        Button("OK", role: .cancel) { }
                    }
                    VStack {
                        if mailConfirmationViewModel.codeSend {
                            checkKey(model: mailConfirmationViewModel, man: $man, сodef: сoder, newPassword: restorePassword)
                        } else {
                            checkKey(model: mailConfirmationViewModel, man: $man, сodef: сoder, newPassword: restorePassword).hidden()
                        }
                    }.padding()
                   

                }.padding(.bottom, 220)
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
        Spacer()
    }
}

struct checkKey: View {
    @ObservedObject var model: LogInViewModel
    @Binding var man: UserInfo
    @State var сodef: String
    var newPassword: Bool
    @State var warning = ""
    var body: some View {
        VStack(alignment: .leading) {
            ClassicTextField(labelText: "Код", fieldText: "Введите код", user: $сodef).padding(.top, 40)
        }.padding(.horizontal, 6)
        Button(action: {
            model.checkEmailCode(сode: сodef)
        }) {
            Text("Проверить").foregroundColor(ColorPalette.buttonText).frame(width: UIScreen.main.bounds.width - 120).padding()
        }.alert("Неправильный код", isPresented: $model.wrongCode) {
            Button("OK", role: .cancel) { }
        }
        .background(ColorPalette.acсentColor)
        .clipShape(Capsule())
        .padding(.top, 50)
        .fullScreenCover(isPresented: $model.showPasswordView) {
            PasswordView(passwordViewModel: model, title: newPassword ? "Новый пароль" : "Регистрация", twoPassword: newPassword, man: $man)
        }
    }
}
