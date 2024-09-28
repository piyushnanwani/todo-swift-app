//
//  TodoListApp.swift
//  TodoList
//
//  Created by Piyush Nanwani on 17/09/24.
//

import SwiftUI

@main
struct TodoListApp: App {
    var body: some Scene {
        WindowGroup {
            if isAuthenticated() {
                ContentView()
            } else {
                LoginView()
            }
            
        }
    }
    
    func isAuthenticated() -> Bool {
        return UserDefaults.standard.string(forKey: "username") != nil
    }
}
