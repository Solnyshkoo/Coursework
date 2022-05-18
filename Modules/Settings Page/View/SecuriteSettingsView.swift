import Foundation
import SwiftUI
struct SecuriteSettingsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var canEdit: Bool = false
    @State var email: String = ""
    @State var pass: String = "**********"
    @ObservedObject var settingsViewModel: SettingsViewModel
    init(output: SettingsViewModel) {
        settingsViewModel = output
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .center, content: {
                    Spacer()
                    Button {
                        if canEdit {
                            settingsViewModel.saveChanges()
                            if settingsViewModel.canSave {
                                self.canEdit.toggle()
                            }
                        } else {
                            self.canEdit.toggle()
                        }
                        
                       
                    } label: {
                        Text(canEdit ? "Готово " : "Править").bold()
                    }

                }).padding(.trailing, 25)
                    .padding(.top, 10)

                Form {
                    Section {
                        VStack(alignment: .horizontalCenterAlignment, spacing: 15) {
                            HStack {
                                Text("Почта").padding(.trailing, 10)
                                
                                if canEdit {
                                    TextField("Почта", text: $settingsViewModel.editableUser.mail)
                                        .foregroundColor(canEdit ? ColorPalette.activeText : ColorPalette.buttonText)
                                } else {
                                    Text(settingsViewModel.user.mail)
                                        .foregroundColor(canEdit ? ColorPalette.activeText : ColorPalette.buttonText)
                                }
                                Spacer()
                            }
                        }
                    }
                    Section {
                        HStack {
                            Text("Пароль").padding(.trailing, 10)
                            if canEdit {
                                TextField("пароль", text: $settingsViewModel.editableUser.password).foregroundColor(canEdit ? ColorPalette.activeText : ColorPalette.buttonText)
                     
                            } else {
                                Text("*************").foregroundColor(canEdit ? ColorPalette.activeText : ColorPalette.buttonText)
                                   
                            }
                           
                        }
                    }
                }.padding(.top, -11)
                    .alert(isPresented: $settingsViewModel.pass, TextAlert(title: "Пароль", message: "Чтобы сменить пароль, введите сюда старый", keyboardType: .numberPad) { result in
                            if result != nil {
                                // Text was accepted
                            } else {
                                settingsViewModel.cancelChanges()
                                canEdit = false
                            }
                        })
                    .alert(isPresented: $settingsViewModel.mailConfirm, TextAlert(title: "Почта", message: "Мы отправили на новую почту, код подтверждения. Введите его ниже.", keyboardType: .numberPad) { result in
                            if result != nil {
                                // Text was accepted
                            } else {
                                canEdit = false
                            }
                        })
                  
            }
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

struct SecuriteSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SecuriteSettingsView(output: SettingsViewModel(service: Service(), tok: "d", user: UserInfo()))
            .preferredColorScheme(.dark)
    }
}

public struct TextAlert {
    public var title: String // Title of the dialog
    public var message: String // Dialog message
    public var placeholder: String = "" // Placeholder text for the TextField
    public var accept: String = "OK" // The left-most button label
    public var cancel: String? = "Cancel" // The optional cancel (right-most) button label
    public var secondaryActionTitle: String? = nil // The optional center button label
    public var keyboardType: UIKeyboardType = .default // Keyboard tzpe of the TextField
    public var action: (String?) -> Void // Triggers when either of the two buttons closes the dialog
    public var secondaryAction: (() -> Void)? = nil // Triggers when the optional center button is tapped
}

extension UIAlertController {
    convenience init(alert: TextAlert) {
        self.init(title: alert.title, message: alert.message, preferredStyle: .alert)
        addTextField {
            $0.placeholder = alert.placeholder
            $0.keyboardType = alert.keyboardType
        }
        if let cancel = alert.cancel {
            addAction(UIAlertAction(title: cancel, style: .cancel) { _ in
                alert.action(nil)
            })
        }
        if let secondaryActionTitle = alert.secondaryActionTitle {
            addAction(UIAlertAction(title: secondaryActionTitle, style: .default, handler: { _ in
                alert.secondaryAction?()
            }))
        }
        let textField = textFields?.first
        addAction(UIAlertAction(title: alert.accept, style: .default) { _ in
            alert.action(textField?.text)
        })
    }
}

struct AlertWrapper<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let alert: TextAlert
    let content: Content

    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertWrapper>) -> UIHostingController<Content> {
        UIHostingController(rootView: content)
    }

    final class Coordinator {
        var alertController: UIAlertController?
        init(_ controller: UIAlertController? = nil) {
            alertController = controller
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: UIViewControllerRepresentableContext<AlertWrapper>) {
        uiViewController.rootView = content
        if isPresented, uiViewController.presentedViewController == nil {
            var alert = self.alert
            alert.action = {
                self.isPresented = false
                self.alert.action($0)
            }
            context.coordinator.alertController = UIAlertController(alert: alert)
            uiViewController.present(context.coordinator.alertController!, animated: true)
        }
        if !isPresented, uiViewController.presentedViewController == context.coordinator.alertController {
            uiViewController.dismiss(animated: true)
        }
    }
}

public extension View {
    func alert(isPresented: Binding<Bool>, _ alert: TextAlert) -> some View {
        AlertWrapper(isPresented: isPresented, alert: alert, content: self)
    }
}
