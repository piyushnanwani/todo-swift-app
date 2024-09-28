//
//  RegisterView.swift
//  TodoList
//
//  Created by Piyush Nanwani on 17/09/24.
//

import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Register") {
                if password == confirmPassword {
                    
                    saveUser(username: username, password: password)
                
                    // reset the textfields
                    username = ""
                    password = ""
                    confirmPassword = ""
                }
            }
        }
        .padding()
    }
    
    func saveUser(username: String, password: String) {
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(password, forKey: "password")
    }
}

#Preview {
    RegisterView()
}
