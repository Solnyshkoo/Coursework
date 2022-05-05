import Foundation
import SwiftUI

protocol MainViewProtocolInput {
    func updateWarning(text: String)
}

protocol MainViewProtocolOutput {
    func validateUser(respond: ValidateUserModel) -> Bool
    func getText() -> String
    func showWarning() -> Bool
    func setView(viewL: MainViewProtocolInput)
    func getService() -> Service
    func getToken() -> String
}

struct MainView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var mainViewModel: LogInViewModel
    @State var man = UserInfo()
    @State var enterText: String = ""
    @State var user = ""
    @State var pass = ""
    @State var hidde = true
    @State private var showingRegistrationView = false
    @State private var showingRestoringView = false
    @State private var showingHoneView = false
    @State private var showingWarning = false
    @State private var warningText = " "

    init (output: LogInViewModel) {
        mainViewModel = output
       
    }
    var body: some View {
        VStack {
            Text("Sign In").fontWeight(.heavy).font(.largeTitle)
    
                .padding([.top, .bottom], 20)
           
            VStack {
                VStack(alignment: .leading) {
                    ClassicTextField(labelText: "Username", fieldText: "Enter Your Username", user: $user).padding(.bottom, 15)
                    SecretTextField(labelText: "Password", fieldText: "Enter Your Password", pass: $pass)
                    Button(action: { showingRestoringView.toggle() }) {
                        Text("Forget password?").font(Font.system(size: 12, design: .default)).padding([.top, .leading], 5)
                    }.foregroundColor(ColorPalette.activeText).fullScreenCover(isPresented: $showingRestoringView) {
                        MailConfirmationView(mailConfirmationViewModel: LogInViewModel(service: Service()), man: $man, restorePassword: true)
                    }
                }.padding(.horizontal, 6)
            }.padding()
            VStack {
                Text(mainViewModel.getText()).foregroundColor(ColorPalette.warningColor).padding(.top, 5)
                Button(action: {
                    showingHoneView = mainViewModel.validateUser(respond: ValidateUserModel(login: user, password: pass))
                        warningText = mainViewModel.getText()
                }) {
                    Text("Sign In").foregroundColor(ColorPalette.text)
                        .frame(width: UIScreen.main.bounds.width - 120).padding()
                }.disabled(user.isEmpty || pass.isEmpty)
                    .background(user.isEmpty || pass.isEmpty ? ColorPalette.disableButtom : ColorPalette.acсentColor)
                    .clipShape(Capsule())
                    .padding(.top, 45)
                    .fullScreenCover(isPresented: $showingHoneView) {
                        TabBar(people: $man, token: mainViewModel.getToken(), service: mainViewModel.getService())
                    }.onTapGesture {
                        if true {
                            self.mode.wrappedValue.dismiss()
                        }
                    }
                    
               
                HStack(spacing: 8) {
                 
                    
                    Button(action: {
                        showingRegistrationView.toggle()

                    }) {
                        Text("Sign Up")
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
//
//extension MainView: MainViewProtocolInput {
//    func updateWarning(text: String) {
//
//        warningText = text
//        showingWarning = text == " " ? false : true
//        showingHoneView = text == " " ?  true : false
//
//    }
//}
//
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
