import Foundation
import SwiftUI
struct AuthorizationView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var mainViewModel: LogInViewModel
    @State var man = UserInfo()
    @State var user = ""
    @State var pass = ""
    @State private var showingRegistrationView = false
    @State private var showingRestoringView = false
    @State private var showPreview = false
    @State private var showAlertRestore = false
    init(output: LogInViewModel) {
        mainViewModel = output
    }

    var body: some View {
        VStack {
            Text("Авторизация").fontWeight(.heavy).font(.largeTitle)
                .padding([.top, .bottom], 20)
            VStack {
                VStack(alignment: .leading) {
                    ClassicTextField(labelText: "Nickname", fieldText: "Введите Nickname", user: $user).padding(.bottom, 15)
                    SecretTextField(labelText: "Пароль", fieldText: "Введите пароль", pass: $pass)
                    Button(action: {
                        if user.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            self.showAlertRestore.toggle()
                        } else {
                            showingRestoringView.toggle()
                        }
                    }){
                        Text("Восстановить пароль?").font(Font.system(size: 12, design: .default)).padding([.top, .leading], 5)
                    }.foregroundColor(ColorPalette.activeText)
                        .fullScreenCover(isPresented: $showingRestoringView) {
                        MailConfirmationView(mailConfirmationViewModel: mainViewModel, man: $man, restorePassword: true)
                    }
                        .alert("Чтобы востановить пароль обязательно введите никней", isPresented: $showAlertRestore) {
                            Button("OK", role: .cancel) { }
                        }
                }.padding(.horizontal, 6)
            }.padding()
            VStack {
                Text(mainViewModel.getText()).foregroundColor(ColorPalette.warningColor).padding(.top, 5)
                Button(action: {
                    mainViewModel.validateUser(respond: ValidateUserModel(login: user, password: pass))
                }) {
                    Text("Войти").foregroundColor(ColorPalette.text)
                        .frame(width: UIScreen.main.bounds.width - 120).padding()
                }.disabled(user.isEmpty || pass.isEmpty)
                    .background(user.isEmpty || pass.isEmpty ? ColorPalette.disableButtom : ColorPalette.acсentColor)
                    .clipShape(Capsule())
                    .padding(.top, 45)
                    .fullScreenCover(isPresented: $mainViewModel.showHomeView) {
                        TabBar(people: $man, token: mainViewModel.getToken(), service: Service())
                    }.onTapGesture {
                        if true {
                            self.mode.wrappedValue.dismiss()
                        }
                    }
                HStack(spacing: 8) {
                    Button(action: {
                        showPreview.toggle()
                    }) {
                        Text("Просмотр")
                    }
                    .foregroundColor(ColorPalette.activeText)
                    .sheet(isPresented: $showPreview) {
                        EventsView(fullAcсess: false)
                        // TODO: - показать превью
                    }
                    Text("или")
                    Button(action: {
                        showingRegistrationView.toggle()
                    }) {
                        Text("Зарегистрироваться")
                    }
                    .foregroundColor(ColorPalette.activeText)
                    .fullScreenCover(isPresented: $showingRegistrationView) {
                        RegistrationView()
                    }
                }.padding(.top, 25)
            }
        }
    }
}
