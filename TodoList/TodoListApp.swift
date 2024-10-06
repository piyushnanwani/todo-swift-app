import SwiftUI

@main
struct TodoListApp: App {
    @State private var isAuthenticated: Bool = UserDefaults.standard.bool(forKey: "isAuthenticated")

    // Initialize the Core Data persistence controller
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            if isAuthenticated {
                // Pass the managed object context to ContentView
                ContentView(isAuthenticated: $isAuthenticated)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                // Pass the managed object context to LoginView, if needed
                LoginView(isAuthenticated: $isAuthenticated)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
