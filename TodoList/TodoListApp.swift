import SwiftUI

@main
struct TodoListApp: App {
    @State private var isAuthenticated: Bool = false // Controls the app flow based on login state
    
    var body: some Scene {
        WindowGroup {
            if isAuthenticated {
                ContentView(isAuthenticated: $isAuthenticated)
            } else {
                LoginView(isAuthenticated: $isAuthenticated)
            }
        }
    }
}
