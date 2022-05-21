import SwiftUI

@main
struct CourseApp: App {
   // let persistenceController = PersistenceController.shared
    @State var man: UserInfo =  UserInfo()
    
    
    var body: some Scene {
        let service = AuthorizationAPIService()
        let presenter = LogInViewModel(service: service)
        
        
        WindowGroup {
          //  EventsView(fullAcсess: true)
         //
       //     SecuriteSettingsView(output: SettingsViewModel(service: Service(), tok: "", user: UserInfo()))
         AuthorizationView(output: LogInViewModel(service: AuthorizationAPIService()))
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
