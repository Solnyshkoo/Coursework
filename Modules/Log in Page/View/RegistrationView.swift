import Foundation
import SwiftUI
struct RegistrationView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Binding var man: UserInfo
    @Environment(\.colorScheme) var colorScheme
    @State private var showingRegistrationView = false
    @State private var shoosePhoto = false
    @State private var selectedColorIndex = 0
    @State private var selectedYear = ""
    @State private var photo: UIImage?
    var years = Array(16 ... 100)
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    ScrollView {
                    VStack {
                        HStack(alignment: .center) {
                            if photo == nil {
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
                                        ImagePicker(image: $photo, isPresented: $shoosePhoto)
                                    }
                            } else {
                                Image(uiImage: photo!)
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle())
                                  
                                    .overlay {
                                    Image(systemName: "camera").resizable().frame(width: 80, height: 60)
                                        .onTapGesture {
                                            shoosePhoto.toggle()
                                        }
                                       
                                        }.foregroundColor(ColorPalette.lightGray2)
                                    .sheet(isPresented: $shoosePhoto) {
                                        ImagePicker(image: $photo, isPresented: $shoosePhoto)
                                    }
                                }
                            
                        }
                        .padding(.bottom, 15)
                        VStack(alignment: .leading) {
                            
                            
                            ClassicTextField(labelText: "Имя", fieldText: "Введите имя", user: $man.name).padding(.bottom, 15)

                            ClassicTextField(labelText: "Фамилия", fieldText: "Введите фамилию", user: $man.surname).padding(.bottom, 15)

                           

                            VStack(alignment: .leading) {
                                Text("Возраст").font(.headline).fontWeight(.light).foregroundColor(Color(.label).opacity(0.75)).padding(.bottom, -3)
                        
                                    Menu {
                                        Picker("0", selection: $man.age) {
                                            ForEach(years, id: \.self) {
                                                Text("\($0.formatted(.number.grouping(.never)))")
                                                    .foregroundColor(Color.red)
                                            }
                                        }
                                        .padding(.bottom, -3)
                                        .padding(.leading, -6)
                                        .colorMultiply(.white)

                                    } label: {
                                        Text(man.age == -1 ? "Выберите возраст" : String(man.age)).foregroundColor(man.age == -1 ? ColorPalette.lightGray2 :ColorPalette.text)
                                            .padding(.top, 5)
                                            .padding(.bottom, -3)
                                    
                                }
                                Divider()
                                    .padding(.bottom, 15)
                            }
                          

                            VStack(alignment: .leading) {
                                Text("Пол").font(.headline).fontWeight(.light).foregroundColor(Color(.label).opacity(0.75)).padding(.bottom, -3)
                                Menu {
                                Picker("Пол", selection: $man.sex) {
                                    Text("").tag("Нет")
                                    Text("Жен").tag("Жен")
                                    Text("Муж").tag("Муж")
                                }.padding(.bottom, -3)
                                    .colorMultiply(ColorPalette.lightGray)
                                } label: {
                                    Text(man.sex == "" ? "Выберите пол" : man.sex).foregroundColor(man.sex == "" ? ColorPalette.lightGray2 :ColorPalette.text)
                                        .padding(.top, 5)
                                        .padding(.bottom, -3)
                                
                            }
                            Divider()
                                .padding(.bottom, 15)
                            }
                        }.padding(.horizontal, 6)
                    }.padding()
                    VStack {
                        Button(action: {
                            if photo == nil {
                                man.image = Image(uiImage:UIImage(imageLiteralResourceName: "noImage"))
                            } else {
                                man.image = Image(uiImage: photo!)
                            }
                            
                            self.showingRegistrationView.toggle()
                        }) {
                            Text("Продолжить").foregroundColor(ColorPalette.text).frame(width: UIScreen.main.bounds.width - 120).padding()

                        }.disabled(man.name.isEmpty || man.surname.isEmpty || man.age == -1)
                            .background(man.name.isEmpty || man.surname.isEmpty || man.age == -1 ? ColorPalette.disableButtom : ColorPalette.acсentColor)
                            .clipShape(Capsule())
                            .padding(.top, 15)
                            .foregroundColor(ColorPalette.activeText).fullScreenCover(isPresented: $showingRegistrationView) {
                                MailConfirmationView(mailConfirmationViewModel: LogInViewModel(service: AuthorizationAPIService()), man: $man, restorePassword: false)
                            }
                    }
                }.padding(.bottom, 100)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden(true)
                    .toolbar(content: {
                        ToolbarItem(placement: .navigation) {
                            HStack(alignment: .center, content: {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(ColorPalette.navigationBarItem)
                                    .onTapGesture {
                                        man = UserInfo()
                                        self.mode.wrappedValue.dismiss()
                                    }
                        
                                Text("Регистрация").fontWeight(.heavy).font(.largeTitle)
                                    .padding(.leading, 55)
                                    .padding(.top, 18)
                    
                            }).padding(.bottom, 20)
                            
                        }                    })
                }
            }
            Spacer()
        }
    }
}

//struct RegistrationViewPreviewContainer_2: View {
//    @State var lol: UserInfo = .init(name: "Ksenia", surname: "Perova", age: 18, nickname: "ksu", password: "123", sex: "female")
//
//    var body: some View {
//        RegistrationView()
//    }
//}
//
//struct RegistrationView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegistrationViewPreviewContainer_2()
//            .preferredColorScheme(.dark)
//    }
//}
