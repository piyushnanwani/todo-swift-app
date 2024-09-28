//
//  LoginView.swift
//  TodoList
//
//  Created by Piyush Nanwani on 17/09/24.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isAuthenticated: Bool = false
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Login") {
                if authenticateUser(username: username, password: password) {
                    isAuthenticated = true
                }
            }
        }
        .padding()
    }
    
    func authenticateUser(username: String, password: String) -> Bool {
        let storedUsername = UserDefaults.standard.string(forKey: "username")
        let storedPassword = UserDefaults.standard.string(forKey: "password")
        
        return storedUsername == username && storedPassword == password
    }
}

#Preview {
    LoginView()
}
