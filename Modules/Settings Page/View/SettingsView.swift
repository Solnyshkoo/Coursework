import Foundation
import SwiftUI

protocol SettingsViewProtocolOutput {}

struct SettingsView: View {
    var settingsViewModel: SettingsViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var showInformationSettings: Bool = false
    @State var showСonfidentialSettings: Bool = false
    @State var showNotificationSettings: Bool = false
    init(output: SettingsViewModel) {
        settingsViewModel = output
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Button(action: {
                        self.showInformationSettings.toggle()
                    }) {
                        Text("Профиль").foregroundColor(ColorPalette.text)
                    }
                    .fullScreenCover(isPresented: $showInformationSettings) {
                        InformationSettingsView()
                    }
                    
                    Button(action: {
                        self.showСonfidentialSettings.toggle()
                    }) {
                        Text("Конфиденциальность").foregroundColor(ColorPalette.text)
                    }
                    .fullScreenCover(isPresented: $showСonfidentialSettings) {
                        СonfidentialSettings()
                    }
                }
                
                Section {
                    Button(action: {
                        self.showNotificationSettings.toggle()
                    }) {
                        Text("Уведомления").foregroundColor(ColorPalette.text)
                    }
                    .fullScreenCover(isPresented: $showNotificationSettings) {
                        NotificationSettings()
                    }
                }
                
                Section {
                    Button(action: {
                    }) {
                        Label("Выйти из профиля", systemImage: "rectangle.portrait.and.arrow.right").foregroundColor(ColorPalette.text)
                      
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
                
                            Text("Настройки").fontWeight(.heavy).font(.title)
                                .padding(.leading, 60)
                                .padding(.top, 18)
            
                        }).padding(.bottom, 5)
                    }
                })
        }.padding(.top, -70)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsView(output: SettingsViewModel(service: Service(), tok: "lol", user: UserInfo(name: "Ksenia", surname: "Petrova", patronymic: "lol", age: 20, nickname: "ksu09", password: "123", number: "12345", mail: "petr", sex: "female", image: Image("photo"), favorities: [], subscribes: [])))
            SettingsView(output: SettingsViewModel(service: Service(), tok: "lol", user: UserInfo(name: "Ksenia", surname: "Petrova", patronymic: "lol", age: 20, nickname: "ksu09", password: "123", number: "12345", mail: "petr", sex: "female", image: Image("photo"), favorities: [], subscribes: [])))
                .preferredColorScheme(.dark)
        }
    }
}
