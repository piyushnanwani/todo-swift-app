import SwiftUI

struct LoginView: View {
    @Binding var isAuthenticated: Bool // Binding to control app flow
    @State private var username: String = "" // Stores the input username
    @State private var password: String = "" // Stores the input password
    @State private var loginFailed: Bool = false // Flag for incorrect login
    
    var body: some View {
        NavigationView {
            VStack {
                // Username Input
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Password Input
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Login Button
                Button("Login") {
                    if authenticateUser(username: username, password: password) {
                        isAuthenticated = true // Set to true on successful login
                        UserDefaults.standard.set(true, forKey: "isAuthenticated") // Update UserDefaults

                    } else {
                        loginFailed = true // Show error message
                    }
                }
                .padding()
                .alert(isPresented: $loginFailed) {
                    Alert(title: Text("Login Failed"), message: Text("Incorrect username or password"), dismissButton: .default(Text("OK")))
                }
                
                // Register Navigation Link
                NavigationLink(destination: RegisterView()) {
                    Text("Not registered? Register here")
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .padding()
            .navigationTitle("Login")
        }
    }
    
    // Function to authenticate the user
    func authenticateUser(username: String, password: String) -> Bool {
        let storedUsername = UserDefaults.standard.string(forKey: "username")
        let storedPassword = UserDefaults.standard.string(forKey: "password")
        
        return storedUsername == username && storedPassword == password
    }
}

#Preview {
    LoginView(isAuthenticated: .constant(false))
}
