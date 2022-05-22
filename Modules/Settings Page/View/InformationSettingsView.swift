import Foundation
import SwiftUI
struct InformationSettingsView: View {
    @ObservedObject var settingsViewModel: SettingsViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Binding var user: UserInfo
    @State var showPersonalSettings: Bool = false
    @State var showSecuriteSettings: Bool = false
    @State var showVerification: Bool = false
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Button(action: {
                        self.showPersonalSettings.toggle()
                    }) {
                     Text("Личные данные").foregroundColor(ColorPalette.buttonText)
                    }
                    .fullScreenCover(isPresented: $showPersonalSettings) {
                        PersonalSettigs(settingsViewModel: settingsViewModel, man: $user)
              
                }
                
                }
                Section {
                    Button(action: {
                        self.showSecuriteSettings.toggle()
                    }) {
                        Text("Безопасность").foregroundColor(ColorPalette.buttonText)
                    }
                    .fullScreenCover(isPresented: $showSecuriteSettings) {
                       SecuriteSettingsView(output: SettingsViewModel(service: Service(), tok: "", user: UserInfo()))
                    }
                    
                    Button(action: {
                        self.showVerification.toggle()
                    }) {
                        Text("Пройти верификацию").foregroundColor(ColorPalette.buttonText)
                    }
                    .fullScreenCover(isPresented: $showVerification) {
                        VerificationView(output:VerificationViewModel(service: Service(), user: user))
                    }
                }
                
            }.padding(.top, 10)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .navigation) {
                        HStack(alignment: .center, content: {
                            Image(systemName: "arrow.left")
                                .foregroundColor(ColorPalette.navigationBarItem)
                                .onTapGesture {
                                    self.mode.wrappedValue.dismiss()
                                }
                
                            Text("Профиль").fontWeight(.heavy).font(.title)
                                .padding(.leading, 90)
                                .padding(.top, 18)
            
                        }).padding(.bottom, 5)
                    }
                })
        }
    }
}

//struct InformationSettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        InformationSettingsView()
//            .preferredColorScheme(.dark)
//    }
//}
