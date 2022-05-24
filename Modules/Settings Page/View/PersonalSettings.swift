import Foundation
import SwiftUI
struct PersonalSettigs: View {
    @ObservedObject var settingsViewModel: SettingsViewModel
    @Binding var man: UserInfo
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var shoosePhoto = false
    @State private var selectedColorIndex = 0
    @State private var selectedYear = ""
    var years = Array(16 ... 100)
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack(alignment: .center) {
                        if  settingsViewModel.photo == nil {
                            Circle()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                .foregroundColor(ColorPalette.secondBackground)
                                .overlay {
                                    Image(systemName: "camera").resizable().frame(width: 80, height: 60)
                                        .onTapGesture {
                                            shoosePhoto.toggle()
                                        }

                                }.foregroundColor(ColorPalette.lightGray2)
                                .sheet(isPresented: $shoosePhoto) {
                                    ImagePicker(image: $settingsViewModel.photo, isPresented: $shoosePhoto)
                                }
                           
                        } else {
                            Image(uiImage: settingsViewModel.photo!)
                                .resizable()
                                .centerSquareCropped()
                                .clipShape(Circle())
                                .frame(width: 160, height: 160)
                                .scaledToFit()
                                .foregroundColor(ColorPalette.secondBackground)
                                .overlay {
                                    ZStack {
                                        Circle().foregroundColor(ColorPalette.lightGray).opacity(0.5).frame(height: 160)
                                        Image(systemName: "camera").resizable().frame(width: 80, height: 60)
                                            .onTapGesture {
                                                shoosePhoto.toggle()
                                            }

                                            .foregroundColor(ColorPalette.lightGray2)
                                            .sheet(isPresented: $shoosePhoto) {
                                                ImagePicker(image: $settingsViewModel.photo, isPresented: $shoosePhoto)
                                            }
                                    }
                                }
                        }
                    }
                    .padding(.bottom, 15)
                    VStack(alignment: .leading) {
                        ClassicTextField(labelText: "Имя", fieldText: "Введите имя", user: $settingsViewModel.editableUser.name).padding(.bottom, 15)
                        ClassicTextField(labelText: "Фамилия", fieldText: "Введите фамилию", user: $settingsViewModel.editableUser.surname).padding(.bottom, 15)

                        VStack(alignment: .leading) {
                            Text("Возраст").font(.headline).fontWeight(.light).foregroundColor(Color(.label).opacity(0.75)).padding(.bottom, -3)
            
                            Menu {
                                Picker("0", selection: $settingsViewModel.editableUser.age) {
                                    ForEach(years, id: \.self) {
                                        Text("\($0.formatted(.number.grouping(.never)))")
                                            .foregroundColor(Color.red)
                                    }
                                }
                                .padding(.bottom, -3)
                                .padding(.leading, -6)
                                .colorMultiply(.white)

                            } label: {
                                Text(settingsViewModel.editableUser.age == -1 ? "Выберите возраст" : String(settingsViewModel.editableUser.age)).foregroundColor(settingsViewModel.editableUser.age == -1 ? ColorPalette.lightGray2 : ColorPalette.text)
                                    .padding(.top, 5)
                                    .padding(.bottom, -3)
                            }
                            Divider()
                                .padding(.bottom, 15)
                        }

                        VStack(alignment: .leading) {
                            Text("Пол").font(.headline).fontWeight(.light).foregroundColor(Color(.label).opacity(0.75)).padding(.bottom, -3)
                            Menu {
                                Picker("Пол", selection: $settingsViewModel.editableUser.sex) {
                                        Text("").tag("Нет")
                                        Text("Жен").tag("Жен")
                                        Text("Муж").tag("Муж")
                                }.padding(.bottom, -3)
                                    .colorMultiply(ColorPalette.lightGray)
                            } label: {
                                Text(settingsViewModel.editableUser.sex == "" ? "Выберите пол" : settingsViewModel.editableUser.sex).foregroundColor(settingsViewModel.editableUser.sex == "" ? ColorPalette.lightGray2 : ColorPalette.text)
                                    .padding(.top, 5)
                                    .padding(.bottom, -3)
                            }
                            Divider().padding(.bottom, 15)
                        }
                        HStack(alignment: .center, spacing: 20, content: {
                            Button(action: {
                                settingsViewModel.cancelChanges()
                            }) {
                                Text("Отменить").font(Font.system(size: 20, design: .default))
                                    .padding(.trailing, 3)
                                    .frame(width: 160, height: 20)
                            }.foregroundColor(ColorPalette.buttonText)
                                .padding()
                                .background(ColorPalette.secondBackground)
                                .cornerRadius(10)
                            Button(action: {
                                if settingsViewModel.photo != nil {
                                    settingsViewModel.editableUser.image = Image(uiImage: settingsViewModel.photo!)
                                }
                                settingsViewModel.checkAllChanges()
                                if settingsViewModel.allFields {
                                    settingsViewModel.saveAllChanges()
                                }
                                if settingsViewModel.saveChanges {
                                    man = settingsViewModel.editableUser
//                                    man.image = Image(uiImage: settingsViewModel.photo!)
                                   
                                }
                            }) {
                                Text("Сохранить").font(Font.system(size: 20, design: .default))
                                    .padding(.trailing, 3)
                                    .frame(width: 160, height: 20)
                            }.foregroundColor(ColorPalette.buttonText)
                                .padding()
                                .background(ColorPalette.acсentColor)
                                .cornerRadius(10)
                                .alert("Не получилось сохранить", isPresented: $settingsViewModel.warningAllChanges) {
                                    Button("OK", role: .cancel) {}
                                }
                                .alert(settingsViewModel.warning, isPresented: $settingsViewModel.notAllFieldsWarning) {
                                    Button("OK", role: .cancel) {}
                                }
                        }).padding(.top, 12)
                    }.padding(.horizontal, 6)
                }.padding()
      
            }.padding(.bottom, 100)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar(content: {
                    ToolbarItem(placement: .navigation) {
                        HStack(alignment: .center, content: {
                            Image(systemName: "arrow.left")
                                .foregroundColor(ColorPalette.navigationBarItem)
                                .onTapGesture {
                                    self.mode.wrappedValue.dismiss()
                                }
            
                            Text("Личные данные").fontWeight(.heavy).font(.title)
                                .padding(.leading, 65)
                                .padding(.top, 18)
        
                        }).padding(.bottom, 20)
                    }
                })
        }
    }
}
