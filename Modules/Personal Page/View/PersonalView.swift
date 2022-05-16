import Foundation
import SwiftUI
import UIKit

protocol PersonalViewProtocolInput {}

protocol PersonalViewProtocolOutput {
    func setView(view: PersonalViewProtocolInput)
    func getFio() -> String
    func getImage() -> Image
    func getNickname() -> String
    func getMyEvents() -> [EventModel]
    func getHistory() -> [EventModel]
    func setPicture(image: Image)
    func getData()
}

struct PersonalView: View {
    var personalViewModel: PersonalViewModel
    @State private var selectedIndex: Int? = 0
    @State private var nameAndSurname = ""
    @State private var nickname = ""
    @State private var photo: Image?
    @State var canEdit = false
    @State var pickPhoto = false
    @State var wrongNameAndSurname = false
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
                                
                               
//                                personalViewModel.setPicture(image: photo ?? personalViewModel.getImage())
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
                                   
                                            .padding(.leading, 10)
                                
                                        TextField(personalViewModel.getNickname(), text: $nickname)
                                  
                                            .font(Font.system(size: 24, design: .default))
                                            .padding(.leading, 16)
                                    } else {
                                        Text(personalViewModel.getFio())
                                            .font(Font.system(size: 32, design: .default))
                                            .bold()
                                            .padding(.leading, 13)
                                
                                        Text(personalViewModel.getNickname())
                                            .font(Font.system(size: 24, design: .default))
                                            .padding(.leading, 16)
                                    }
                                }
                                Spacer()
                                if canEdit {
                                    Menu {
                                        Section {
                                            Button(action: {
                                                self.canEdit.toggle()
                                                let fio: [String.SubSequence] = nameAndSurname.split(separator: " ")
                                                if fio.capacity != 2 {
                                                    wrongNameAndSurname.toggle()
                                                    warning = "Обязательно напишите фамилию и имя и разделити их пробелами"
                                                } else if nickname.trimmingCharacters(in: .whitespaces) == "" {
                                                    wrongNameAndSurname.toggle()
                                                    warning = "Обязательно напишите никнейм"
                                                }
                                                personalViewModel.changePhoto(image: photo ?? personalViewModel.getImage())
                                                personalViewModel.changeNickname(nick: nickname)
                                                warning = personalViewModel.nicknameWarningText
                                                print(warning)
                                            }) {
                                                Text("Save")
                                            }.alert(warning, isPresented: $wrongNameAndSurname) {
                                                Button("OK", role: .cancel) { }
                                            }
                                            Button(action: {
                                                self.canEdit.toggle()
                            
                                                // TODO: - старые данные
                                            }) {
                                                Text("Cancel")
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
                                                // TODO: - подробнее
                                            }) {
                                                Label("Settings", systemImage: "gearshape")
                                            }
                                        }
//                                        Section {
//                                            Button(action: {
//                                                // TODO: - подробнее
//                                            }) {
//                                                Label("Favorite", systemImage: "heart")
//                                            }
//                                        }
                                        
                                        Section {
                                            Button(action: {
                                                self.canEdit.toggle()
                            
                                                // TODO: - подробнее
                                            }) {
                                                Text("Edit")
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
                        }
                        
                    setPicker(titles: ["History", "My events"])
                        .padding(.top, -50)
                        .padding(.bottom, 5)
                    Spacer()
                    if selectedIndex == 0 {
                        ForEach(personalViewModel.getHistory()) { item in
                            EventCell(info: item)
                        }
                       
                    } else {
                        ForEach(personalViewModel.getMyEvents()) { item in
                            EventCell(info: item)
                        }
                    }
                }
                
            }.edgesIgnoringSafeArea(.top)
        }
    }
    
    @ViewBuilder
    private func setPicker(titles: [String]) -> some View {
        SegmentedPicker(["History", "My events"], selectedIndex: $selectedIndex) { tab, _ in
            Text(tab)
        }
    }
}

extension PersonalView: PersonalViewProtocolInput {}

struct PersonalView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PersonalView(output: PersonalViewModel(service: Service(), tok: "lol"))
            PersonalView(output: PersonalViewModel(service: Service(), tok: "lol"))
                .preferredColorScheme(.dark)
        }
    }
}
