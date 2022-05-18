import Foundation
import SwiftUI
struct InformationSettingsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var showPersonalSettings: Bool = false
    @State var showSecuriteSettings: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Личные данные")
                    }.onTapGesture {
                        self.showPersonalSettings.toggle()
                    }
                }
                .fullScreenCover(isPresented: $showPersonalSettings) {
                    PersonalSettigs()
                }
                Section {
                    HStack {
                        Text("Безопасность")
                    }.onTapGesture {
                        self.showSecuriteSettings.toggle()
                    }
                    .fullScreenCover(isPresented: $showSecuriteSettings) {
                    //    SecuriteSettingsView()
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
                
                            Text("Информация").fontWeight(.heavy).font(.title)
                                .padding(.leading, 60)
                                .padding(.top, 18)
            
                        }).padding(.bottom, 5)
                    }
                })
        }
    }
}

struct InformationSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        InformationSettingsView()
            .preferredColorScheme(.dark)
    }
}
