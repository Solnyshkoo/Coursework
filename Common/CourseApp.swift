import SwiftUI

@main
struct CourseApp: App {
   // let persistenceController = PersistenceController.shared
    @State var man: UserInfo =  UserInfo()
    
    
    var body: some Scene {
        let service = Service()
        let presenter = LogInViewModel(service: service)
        
        
        WindowGroup {
           // MainView(output: LogInViewModel(service: Service()))
           TabBar(people: $man, token: "lol", service: service)
        }
    }
}
