import Foundation
import SwiftUI
struct AuthorizationView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var mainViewModel: LogInViewModel
    @State var man = UserInfo()
    @State var user = ""
    @State var pass = ""
    @State var hidde = true
    @State private var showingRegistrationView = false
    @State private var showingRestoringView = false
    @State private var showingHomeView: Bool = false
    @State private var showingWarning = false
    @State private var warningText = " "
    @State private var showPreview = false

    init (output: LogInViewModel) {
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
                    Button(action: { showingRestoringView.toggle() }) {
                        Text("Востановить пароль?").font(Font.system(size: 12, design: .default)).padding([.top, .leading], 5)
                    }.foregroundColor(ColorPalette.activeText).fullScreenCover(isPresented: $showingRestoringView) {
                        MailConfirmationView(mailConfirmationViewModel: mainViewModel, man: $man, restorePassword: true)
                    }
                }.padding(.horizontal, 6)
            }.padding()
            VStack {
                Text(mainViewModel.getText()).foregroundColor(ColorPalette.warningColor).padding(.top, 5)
                Button(action: {
                    mainViewModel.validateUser(respond: ValidateUserModel(login: user, password: pass))
                    showingHomeView = mainViewModel.showHomeView
                        warningText = mainViewModel.getText()
                }) {
                    Text("Войти").foregroundColor(ColorPalette.text)
                        .frame(width: UIScreen.main.bounds.width - 120).padding()
                }.disabled(user.isEmpty || pass.isEmpty)
                    .background(user.isEmpty || pass.isEmpty ? ColorPalette.disableButtom : ColorPalette.acсentColor)
                    .clipShape(Capsule())
                    .padding(.top, 45)
                    .fullScreenCover(isPresented: $showingHomeView) {
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
                        Circle()
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

