import Foundation
import SwiftUI
struct EditEventView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var editEventViewModel: EditEventViewModel
    @Binding var user: UserInfo
    @State private var shoosePhoto = false
    @State private var isShowCalendar = false
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                    Text("Редактирование").fontWeight(.heavy).font(.largeTitle).padding(.top, -50)
                        .padding(.bottom, 20)
                    HStack(alignment: .center) {
                        if editEventViewModel.photo ==  UIImage(imageLiteralResourceName: "noImage") {
                            Circle()
                                .frame(width: 150, height: 150)
                                .foregroundColor(ColorPalette.secondBackground)
                                .overlay {
                                    Image(systemName: "camera").resizable().frame(width: 80, height: 60)
                                        .onTapGesture {
                                            shoosePhoto.toggle()
                                        }

                                }.foregroundColor(ColorPalette.lightGray2)
                                .sheet(isPresented: $shoosePhoto) {
                                    ImagePicker(image: $editEventViewModel.photo, isPresented: $shoosePhoto)
                                }
                        } else {
                            Image(uiImage: editEventViewModel.photo!)
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 150, height: 150)
                                .foregroundColor(ColorPalette.secondBackground)
                                .overlay {
                                    Image(systemName: "camera").resizable().frame(width: 80, height: 60)
                                        .onTapGesture {
                                            shoosePhoto.toggle()
                                        }

                                }.foregroundColor(ColorPalette.lightGray2)
                                .sheet(isPresented: $shoosePhoto) {
                                    ImagePicker(image: $editEventViewModel.photo, isPresented: $shoosePhoto)
                                }
                        }
                        
                      
                    }
                    .padding(.bottom, 15)
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text("Дата").font(.title2).fontWeight(.light).foregroundColor(ColorPalette.text).padding(.leading, 18)
                                .padding(.bottom, -1)
                            DatePicker("", selection: $editEventViewModel.editableEvent.data, displayedComponents: .date)
                                .datePickerStyle(CompactDatePickerStyle())
                                .frame(width: 150)
                        }.padding(.top, 10)
                        
                        EventTextField(text: $editEventViewModel.editableEvent.name, title: "Название", subtitile: "Название", width: 40)
                        EventTextField(text: $editEventViewModel.editableEvent.description, title: "Описание", subtitile: "Расскажи, что там будет..", width: 100)
                        EventTextField(text: $editEventViewModel.editableEvent.distination, title: "Местоположение", subtitile: "Адрес", width: 40)
                        EventTextField(text: $editEventViewModel.editableEvent.price, title: "Стоимость входа в рублях", subtitile: "0, если бесплатно", width: 40)
                        EventTextField(text: $editEventViewModel.editableEvent.contacts, title: "Контакты", subtitile: "И как к вам записаться?", width: 60)
                        Divider()
                    }
                    HStack(alignment: .center, spacing: 20, content: {
                        Button(action: {
                            editEventViewModel.cancelChanges()
                            self.mode.wrappedValue.dismiss()
                        }) {
                            Text("Отменить").font(Font.system(size: 20, design: .default))
                                .padding(.trailing, 3)
                                .frame(width: 160, height: 20)
                        }.foregroundColor(ColorPalette.buttonText)
                            .padding()
                            .background(ColorPalette.secondBackground)
                            .cornerRadius(10)
                        Button(action: {
                            editEventViewModel.saveEvent()
                            if editEventViewModel.first && editEventViewModel.second && editEventViewModel.third && editEventViewModel.fourth  && editEventViewModel.fivth && editEventViewModel.six  {
                                let index = user.organiesed.firstIndex(where: {$0.id == editEventViewModel.editableEvent.id})
                                user.organiesed[index!] = editEventViewModel.editableEvent
                                self.mode.wrappedValue.dismiss()
                            }

                        }) {
                            Text("Изменить").font(Font.system(size: 20, design: .default))
                                .padding(.trailing, 3)
                                .frame(width: 160, height: 20)
                        }.foregroundColor(ColorPalette.buttonText)
                            .padding()
                            .background(ColorPalette.acсentColor)
                            .cornerRadius(10)
                            .alert(editEventViewModel.textWarning, isPresented: $editEventViewModel.showWarning) {
                                Button("OK", role: .cancel) {}
                            }

                    }).padding(.top, 12)
                    Spacer()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarBackButtonHidden(true)
                        .toolbar(content: {
                            ToolbarItem(placement: .navigation) {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(ColorPalette.navigationBarItem)
                                    .onTapGesture {
                                     //   event = EventModel()
                                        self.mode.wrappedValue.dismiss()
                                    }
                            }
                        })
                }
            }
        }
    }
}

