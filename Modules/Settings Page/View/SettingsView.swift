import Foundation
import SwiftUI

protocol SettingsViewProtocolOutput {
    
}
struct SettingsView: View {
    var settingsViewModel: SettingsViewProtocolOutput
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    init(output: SettingsViewProtocolOutput) {
        settingsViewModel = output
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                
                Section() {
                    HStack {
                        Text("Информация")
                    }.onTapGesture {
                        
                    }
//                    .fullScreenCover(isPresented: $showFavorite) {
//                        FavoriteView(people: $people)
//                    }
                    
                    HStack {
                        Text("Конфиденциальность")
                    }.onTapGesture {
                        
                    }
//                    .fullScreenCover(isPresented: $showFavorite) {
//                        FavoriteView(people: $people)
//                    }
                }
                
                Section() {
                    HStack {
                        Text("Уведомления")
                    }.onTapGesture {
                        
                    }
//                    .fullScreenCover(isPresented: $showFavorite) {
//                        FavoriteView(people: $people)
//                    }
                    

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
            
//            .navigationBarItems(
//                trailing:
//                Button(
//                    action: {
//                        self.presentationMode.wrappedValue.dismiss()
//                    },
//                    label: {
//                        Text("Done")
//                    }
//                )
//            )
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
