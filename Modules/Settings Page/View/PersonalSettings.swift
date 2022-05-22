import Foundation
import SwiftUI
struct PersonalSettigs: View {
    @State private var man = UserInfo(name: "Ksenia", surname: "Petrova", patronymic: "Эдуардовна", age: 19, nickname: "ksu", password: "", number: "0000", mail: "kepetrova@edu.hse.ru", sex: "female", favorities: [], subscribes: [EventModel(id: 1, name: "reading.club", logo: Image("logoRead"), mainPhoto: Image("photoRead"), distination: "", price: "100", description: "Привет! Мы приглашаем тебе на посиделки в антикафе. Обсудим книги, поделимся впечатлениемя. И да, каждого ждёт сюрприз", participant: 5, like: false, data: Date(), contacts: "")], organiesed: [])
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var shoosePhoto = false
    @State private var selectedColorIndex = 0
    @State private var selectedYear = ""
    @State private var photo: Image?
    var years = Array(16 ... 100)
    var body: some View {
        NavigationView {
        ScrollView {
        VStack {
            HStack(alignment: .center) {
                man.image?.centerSquareCropped()
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
                        ImagePicker(image: $photo, isPresented: $shoosePhoto)
                    }
                        }
                }
            }
            .padding(.bottom, 15)
            VStack(alignment: .leading) {
                
                
                ClassicTextField(labelText: "Имя", fieldText: "Введите имя", user: $man.name).padding(.bottom, 15)

                ClassicTextField(labelText: "Фамилия", fieldText: "Введите фамилию", user: $man.surname).padding(.bottom, 15)

                ClassicTextField(labelText: "Отчество", fieldText: "Введите отчество(не обязательно)", user: $man.patronymic).padding(.bottom, 15)

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
                ClassicTextField(labelText: "Телефон", fieldText: "Введите телефон(не обязательно)", user: $man.number).padding(.bottom, 15)

                VStack(alignment: .leading) {
                    Text("Пол").font(.headline).fontWeight(.light).foregroundColor(Color(.label).opacity(0.75)).padding(.bottom, -3)
                    Menu {
                    Picker("Пол", selection: $man.sex) {
                        Text("").tag("none")
                        Text("Ж").tag("female")
                        Text("М").tag("male")
                    }.padding(.bottom, -3)
                        .colorMultiply(ColorPalette.lightGray)
                    } label: {
                        Text(man.sex == "" ? "Выберите пол" : man.sex).foregroundColor(man.sex == "" ? ColorPalette.lightGray2 :ColorPalette.text)
                            .padding(.top, 5)
                            .padding(.bottom, -3)
                    
                }
                Divider() .padding(.bottom, 15)
                }
                HStack(alignment: .center, spacing: 20, content: {
                    Button(action: {
                        // TODO: - подробнее
                    }) {
                        Text("Отменить").font(Font.system(size: 20, design: .default))
                            .padding(.trailing, 3)
                            .frame(width: 160, height: 20)
                    }.foregroundColor(ColorPalette.buttonText)
                        .padding()
                        .background(ColorPalette.secondBackground)
                        .cornerRadius(10)
                       // .padding(.top, 10)
                        //.padding(.trailing, 10)
                    
                    Button(action: {
                        // TODO: - подробнее
                    }) {
                        Text("Сохранить").font(Font.system(size: 20, design: .default))
                            .padding(.trailing, 3)
                            .frame(width: 160, height: 20)
                    }.foregroundColor(ColorPalette.buttonText)
                        .padding()
                        .background(ColorPalette.acсentColor)
                        .cornerRadius(10)
                       
                      //  .padding(.trailing, 10)
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
                
            }                    })
        }
    }
}


struct PersonalSettigs_Previews: PreviewProvider {
    static var previews: some View {
        PersonalSettigs()
            .preferredColorScheme(.dark)
    }
}
