import SwiftUI

@main
struct CourseApp: App {
   // let persistenceController = PersistenceController.shared
    @State var man: UserInfo =  UserInfo()
    
    
    var body: some Scene {
        let service = Service()
        let presenter = LogInViewModel(service: service)
        
        
        WindowGroup {
           // MainView(output: presenter)
           TabBar(people: $man, token: "lol", service: service)
        }
    }
}
