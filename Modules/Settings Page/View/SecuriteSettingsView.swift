import Foundation
import SwiftUI
struct SecuriteSettingsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var canEdit: Bool = false
    @State var email: String = ""
    @State var pass: String = "**********"
    @ObservedObject var settingsViewModel: SettingsViewModel
    init(output: SettingsViewModel) {
        settingsViewModel = output
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .center, content: {
                    Spacer()
                    Button {
                        if canEdit {
                            settingsViewModel.saveSecurityChanges()
                            if settingsViewModel.canSave {
                                self.canEdit.toggle()
                            }
                        } else {
                            self.canEdit.toggle()
                        }
                        
                       
                    } label: {
                        Text(canEdit ? "Готово " : "Править").bold()
                    }

                }).padding(.trailing, 25)
                    .padding(.top, 10)

                Form {
                    Section {
                        VStack(alignment: .horizontalCenterAlignment, spacing: 15) {
                            HStack {
                                Text("Почта").padding(.trailing, 10)
                                
                                if canEdit {
                                    TextField("Почта", text: $settingsViewModel.editableUser.mail)
                                        .foregroundColor(canEdit ? ColorPalette.activeText : ColorPalette.buttonText)
                                } else {
                                    Text(settingsViewModel.user.mail)
                                        .foregroundColor(canEdit ? ColorPalette.activeText : ColorPalette.buttonText)
                                }
                                Spacer()
                            }
                        }
                    }
                    Section {
                        HStack {
                            Text("Пароль").padding(.trailing, 10)
                            if canEdit {
                                TextField("пароль", text: $settingsViewModel.editableUser.password).foregroundColor(canEdit ? ColorPalette.activeText : ColorPalette.buttonText)
                     
                            } else {
                                Text("*************").foregroundColor(canEdit ? ColorPalette.activeText : ColorPalette.buttonText)
                                   
                            }
                           
                        }
                    }
                }.padding(.top, -11)
                    .alert(isPresented: $settingsViewModel.pass, TextAlert(title: "Пароль", message: "Чтобы сменить пароль, введите сюда старый", keyboardType: .numberPad) { result in
                            if result != nil {
                                // Text was accepted
                            } else {
                                settingsViewModel.cancelChanges()
                                canEdit = false
                            }
                        })
                    .alert(isPresented: $settingsViewModel.mailConfirm, TextAlert(title: "Почта", message: "Мы отправили на новую почту, код подтверждения. Введите его ниже.", keyboardType: .numberPad) { result in
                            if result != nil {
                                // Text was accepted
                            } else {
                                canEdit = false
                            }
                        })
                  
            }
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

                        Text("Безопасность").fontWeight(.heavy).font(.title)
                            .padding(.leading, 60)
                            .padding(.top, 18)

                    }).padding(.bottom, 5)
                }
            })
        }
    }
}

struct SecuriteSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SecuriteSettingsView(output: SettingsViewModel(service: Service(), tok: "d", user: UserInfo()))
            .preferredColorScheme(.dark)
    }
}





