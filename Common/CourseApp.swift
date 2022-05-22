import SwiftUI

@main
struct CourseApp: App {
   // let persistenceController = PersistenceController.shared
    @State var man: UserInfo =  UserInfo()
    @StateObject var navigationUtil = NavigationUtil()
    
    var body: some Scene {
        let service = AuthorizationAPIService()
        let presenter = LogInViewModel(service: service)
        
        
        WindowGroup {
            if navigationUtil.isAuth {
              //  TabBar(newUser: <#T##Bool#>, people: <#T##Binding<UserInfo>#>, token: <#T##String#>, service: <#T##Service#>)
            } else {
                AuthorizationView(output: LogInViewModel(service: AuthorizationAPIService()))
            }
          //  EventsView(fullAcсess: true)
         //
       //     SecuriteSettingsView(output: SettingsViewModel(service: Service(), tok: "", user: UserInfo()))
   
           //   PasswordView(passwordViewModel: presenter, title: "Nickname и пароль", twoPassword: false, man: UserInfo())
           // EventsView()
          // EventDetailView()
          //  ParticipantsView()
      //  PersonalView(output: PersonalViewModel(service: Service(), tok: ""))
            //   SettingsView(output: SettingsViewModel(service: Service(), tok: "", user: UserInfo()))
           // PersonalSettigs()
           // СonfidentialSettings()
          //  NotificationSettings()
           // FavoriteView()
            //OrganizerView()
            //NewEventView()
          //  VerificationView()
         // TabBar(people: $man, token: "lol", service: Service())
           // PersonalView(output: PersonalViewModel(service: Service(), tok: "8Z1wNyFW6OZJI1Ypp3HzQg"))
        }
    }
}
