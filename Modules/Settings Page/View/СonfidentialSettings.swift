import Foundation
import SwiftUI

struct СonfidentialSettings: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var first: Bool = true
    @State var second: Bool = true
    @State var third: Bool = false
    @State var fourth: Bool = true
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Разрешить просматривать аккаун").padding([.bottom, .top], 5)
                            .padding(.trailing, 30)
                        Spacer()
                        if first {
                            Image("done")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 30, height: 30)
                                .foregroundColor(ColorPalette.text)
                        }
                    }.onTapGesture {
                        self.first.toggle()
                    }
                    
                    HStack {
                        Text("Разрешить показывать, мероприятия на которые я иду")
                            .padding([.bottom, .top], 5)
                            .padding(.trailing, 30)
                        Spacer()
                        if second {
                            Image("done")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 30, height: 30)
                                .foregroundColor(ColorPalette.text)
                        }
                    }.onTapGesture {
                        self.second.toggle()
                    }
                }
                
                Section {
                    HStack {
                        Text("Разрешить показывать, мероприятия, которые организую я в профиле").padding([.bottom, .top], 5)
                            .padding(.trailing, 30)
                        Spacer()
                        if third {
                            Image("done")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 30, height: 30)
                                .foregroundColor(ColorPalette.text)
                        }
                    }.onTapGesture {
                        self.third.toggle()
                    }
                    HStack {
                        Text("Разрешить показывать свой аккаунт в списках, записавшихся на мероприятие").padding([.bottom, .top], 5)
                            .padding(.trailing, 30)
                        Spacer()
                        if fourth {
                            Image("done")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 30, height: 30)
                                .foregroundColor(ColorPalette.text)
                        }
                    }.onTapGesture {
                        self.fourth.toggle()
                    }
                }
                
                Section {
                    HStack {
                        Text("Удалить аккаунт")
                        Spacer()
                        Image(systemName: "trash")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 20, height: 24)
                            .foregroundColor(.red)
                    }.onTapGesture {}
                }
            }
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
                        Text("Конфиденциальность").fontWeight(.heavy).font(.title)
                            .padding(.leading, 20)
                            .padding(.top, 18)
            
                    }).padding(.bottom, 20)
                }
            })
        }
    }
}

struct СonfidentialSettings_Previews: PreviewProvider {
    static var previews: some View {
        СonfidentialSettings()
            .preferredColorScheme(.dark)
    }
}
