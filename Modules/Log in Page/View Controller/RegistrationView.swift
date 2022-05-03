import Foundation
import SwiftUI
struct RegistrationView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var man = UserInfo()
    @Environment(\.colorScheme) var colorScheme
    //  @StateObject private var mainViewMode = LogInViewModel()
    @State private var showingRegistrationView = false
    @State private var selectedColorIndex = 0
    @State private var selectedYear = ""
    var years = Array(16 ... 100)
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    VStack {
                        Text("Registration").fontWeight(.heavy).font(.largeTitle).padding([.top, .bottom], 35)
                        VStack(alignment: .leading) {
                            ClassicTextField(labelText: "Name", fieldText: "Write your name", user: $man.name).padding(.bottom, 15)

                            ClassicTextField(labelText: "Surname", fieldText: "Write your Surname", user: $man.surname).padding(.bottom, 15)

                            ClassicTextField(labelText: "Patronymic", fieldText: "Write your patronymic (optional)", user: $man.patronymic).padding(.bottom, 15)

                            VStack(alignment: .leading) {
                                Text("Age").font(.headline).fontWeight(.light).foregroundColor(Color(.label).opacity(0.75)).padding(.bottom, -3)
                        
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
                                        Text(man.age == -1 ? "Choose your age" : String(man.age)).foregroundColor(man.age == -1 ? ColorPalette.lightGray2 :ColorPalette.text)
                                            .padding(.top, 5)
                                            .padding(.bottom, -3)
                                    
                                }
                                Divider()
                                    .padding(.bottom, 15)
                            }
                            ClassicTextField(labelText: "Number", fieldText: "Write your number (optional)", user: $man.number).padding(.bottom, 15)

                            VStack(alignment: .leading) {
                                Text("Sex").font(.headline).fontWeight(.light).foregroundColor(Color(.label).opacity(0.75)).padding(.bottom, -3)
                                Menu {
                                Picker("sex", selection: $man.sex) {
                                    Text("").tag("none")
                                    Text("female").tag("female")
                                    Text("male").tag("male")
                                }.padding(.bottom, -3)
                                    .colorMultiply(ColorPalette.lightGray)
                                } label: {
                                    Text(man.sex == "" ? "Choose your sex" : man.sex).foregroundColor(man.sex == "" ? ColorPalette.lightGray2 :ColorPalette.text)
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
                            self.showingRegistrationView.toggle()
                        }) {
                            Text("Continue").foregroundColor(ColorPalette.text).frame(width: UIScreen.main.bounds.width - 120).padding()

                        }.disabled(man.name.isEmpty || man.surname.isEmpty || man.age == -1)
                            .background(man.name.isEmpty || man.surname.isEmpty || man.age == -1 ? ColorPalette.disableButtom : ColorPalette.acсentColor)
                            .clipShape(Capsule())
                            .padding(.top, 15)
                            .foregroundColor(ColorPalette.activeText).fullScreenCover(isPresented: $showingRegistrationView) {
                                MailConfirmationView(mailConfirmationViewModel: LogInViewModel(service: Service()), man: $man, restorePassword: false)
                            }
                    }
                }.padding(.bottom, 100)
                    .navigationBarBackButtonHidden(true)
                    .toolbar(content: {
                        ToolbarItem(placement: .navigation) {
                            Image(systemName: "arrow.left")
                                .foregroundColor(ColorPalette.navigationBarItem)
                                .onTapGesture {
                                    self.mode.wrappedValue.dismiss()
                                }
                        }
                    })
            }
            Spacer()
        }
    }
}

struct RegistrationViewPreviewContainer_2: View {
    @State var lol: UserInfo = .init(name: "Ksenia", surname: "Perova", age: 18, nickname: "ksu", password: "123", sex: "female")

    var body: some View {
        RegistrationView()
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationViewPreviewContainer_2()
            .preferredColorScheme(.dark)
    }
}
