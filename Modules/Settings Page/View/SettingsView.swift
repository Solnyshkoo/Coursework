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
                    HStack {
                        Text("Информация")
                    }.onTapGesture {
                        self.showInformationSettings.toggle()
                    }
                    .fullScreenCover(isPresented: $showInformationSettings) {
                        InformationSettingsView()
                    }
                    
                    HStack {
                        Text("Конфиденциальность")
                    }.onTapGesture {
                        self.showСonfidentialSettings.toggle()
                    }
                    .fullScreenCover(isPresented: $showСonfidentialSettings) {
                        СonfidentialSettings()
                    }
                }
                
                Section {
                    HStack {
                        Text("Уведомления")
                    }.onTapGesture {
                        self.showNotificationSettings.toggle()
                    }
                    .fullScreenCover(isPresented: $showNotificationSettings) {
                        NotificationSettings()
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
                
                            Text("Настройки").fontWeight(.heavy).font(.largeTitle)
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
