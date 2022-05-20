import Foundation
import SwiftUI
import UIKit

protocol PersonalViewProtocolInput {
    func save()
}

struct PersonalView: View {
    @ObservedObject  var personalViewModel: PersonalViewModel
    @State private var selectedIndex: Int? = 0
    @State private var nameAndSurname = ""
    @State private var nickname = ""
    @State private var photo: Image?
    @State var canEdit = false
    @State var pickPhoto = false
    @State var wrongNameAndSurname = false
    @State var showSettings = false
    @State private var warning = ""
    
    init(output: PersonalViewModel) {
        personalViewModel = output
        personalViewModel.setView(view: self)
        nameAndSurname = personalViewModel.getFio()
        nickname = personalViewModel.getNickname()
    }

    var body: some View {
        VStack {
            VStack {
                ScrollView {
                    personalViewModel.user.image
                        .bigRectangleCropped()
                        .frame(height: 600)
                        .padding(.bottom, 70)
                        .overlay(alignment: .top) {
                            if canEdit {
                                ZStack {
                                    Rectangle().foregroundColor(ColorPalette.lightGray).opacity(0.5).frame(height: 500)
                                
                                    VStack {
                                        Image(systemName: "camera").resizable().frame(width: 100, height: 80)
                                            .onTapGesture {
                                                pickPhoto.toggle()
                                            }
                                            .sheet(isPresented: $pickPhoto) {
                                                ImagePicker(image: $photo, isPresented: $pickPhoto)
                                            }
                                    }.padding(.bottom, 100)
                                }
                            }
                        }
                        .overlay(alignment: .bottom) {
                            Rectangle().frame(width: 600, height: 240).foregroundColor(ColorPalette.mainBackground).rotationEffect(Angle(degrees: -20))
                            Rectangle().frame(width: 560, height: 150).foregroundColor(ColorPalette.mainBackground).opacity(0.6).rotationEffect(Angle(degrees: 21))
                        }
                        .overlay(alignment: .leading) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    if canEdit {
                                        TextField(personalViewModel.getFio(), text: $nameAndSurname)
                                            .foregroundColor(Color.white)
                                            .font(Font.system(size: 32, design: .default))
                                   
                                            .padding(.leading, 12)
                                        HStack {
                                            Text("@") .font(Font.system(size: 24, design: .default))
                                            TextField(personalViewModel.getNickname(), text: $nickname)
                                                .font(Font.system(size: 24, design: .default))
                                            Spacer()
                                        }
                                        .padding(.leading, 16)
                                    } else {
                                        Text(personalViewModel.getFio())
                                            .font(Font.system(size: 32, design: .default))
                                            .bold()
                                            .padding(.leading, 13)
                                
                                        Text("@ " + personalViewModel.getNickname())
                                            .font(Font.system(size: 24, design: .default))
                                            .padding(.leading, 16)
                                    }
                                }
                                Spacer()
                                if canEdit {
                                    Menu {
                                        Section {
                                            Button(action: {
                                                let fio: [String.SubSequence] = nameAndSurname.split(separator: " ")
                                                if fio.capacity != 2 {
                                                    wrongNameAndSurname =  true
                                                    warning = "Обязательно напишите фамилию и имя и разделити их пробелами"
                                                }
                                                if nickname.trimmingCharacters(in: .whitespaces) == "" {
                                                    wrongNameAndSurname =  true
                                                    warning = "Обязательно напишите никнейм"
                                                }
                                                if !wrongNameAndSurname {
                                                    wrongNameAndSurname =  false
                                                    warning = ""
                                                    personalViewModel.changePhoto(image: photo ?? personalViewModel.getImage())
                                                    personalViewModel.changeNickname(nick: nickname)
                                                   // self.canEdit.toggle()
                                                }

//
                                                warning = personalViewModel.nicknameWarningText
                                                print(warning)
                                               
                                            }) {
                                                Text("Сохранить")
                                            }
                                            Button(action: {
                                                self.canEdit.toggle()
                            
                                                // TODO: - старые данные
                                            }) {
                                                Text("Отмена")
                                            }
                                        }
                                    } label: {
                                        Image("done")
                                            .resizable()
                                            .renderingMode(.template)
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(ColorPalette.text)
                                    }
                                } else {
                                    Menu {
                                        Section {
                                             Button(action: {
                                                self.showSettings.toggle()
                                            }) {
                                                Label("Настройки", systemImage: "gearshape")
                                            }
                                        }
                                        
                                        Section {
                                            Button(action: {
                                                self.canEdit.toggle()
                            
                                                // TODO: - подробнее
                                            }) {
                                                Text("Редактировать")
                                            }
                                        }
                                        
                                    } label: {
                                        Image("more.info")
                                            .resizable()
                                            .renderingMode(.template)
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(ColorPalette.text)
                                    }
                                }
                            }.padding(.top, 445)
                                .fullScreenCover(isPresented: $showSettings, content: {
                                    SettingsView(output: SettingsViewModel(service: Service(), tok: "", user: UserInfo()))
                                })
                                .alert(personalViewModel.warningText, isPresented: $personalViewModel.warning) {
                                    Button("OK", role: .cancel) {}
                                }
                                .alert(warning, isPresented: $wrongNameAndSurname) {
                                    Button("OK", role: .cancel) {}
                                }
                                
                        }
                        
                    setPicker(titles: ["История", "Мои мероприятия"])
                        .padding(.top, -50)
                        .padding(.bottom, 5)
                    Spacer()
                    if selectedIndex == 0 {
                        ForEach(personalViewModel.getHistory()) { item in
                            EventCell(info: item, fullAcсess: true, canEdit: false)
                        }
                       
                    } else {
                        ForEach(personalViewModel.getMyEvents()) { item in
                            EventCell(info: item, fullAcсess: true, canEdit: false)
                        }
                    }
                }
                
            }.edgesIgnoringSafeArea(.top)
        }
    }
    
    @ViewBuilder
    private func setPicker(titles: [String]) -> some View {
        SegmentedPicker(["История", "Мои мероприятия"], selectedIndex: $selectedIndex) { tab, _ in
            Text(tab)
        }
    }
    
   
}

extension PersonalView: PersonalViewProtocolInput {
    func save() {
        self.canEdit = true
    }
}

//struct PersonalView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            PersonalView(output: PersonalViewModel(service: Service(), tok: "lol"))
//            PersonalView(output: PersonalViewModel(service: Service(), tok: "lol"))
//                .preferredColorScheme(.dark)
//        }
//    }
//}
