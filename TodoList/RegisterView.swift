import SwiftUI

struct RegisterView: View {
    @State private var username: String = "" // Stores the input username
    @State private var password: String = "" // Stores the input password
    @State private var confirmPassword: String = "" // Stores confirmation password
    @State private var showAlert: Bool = false // Flag to show an alert
    @State private var isRegistrationSuccessful: Bool = false // Differentiates between success and failure
    
    var body: some View {
        VStack {
            // Username Input
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Password Input
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Confirm Password Input
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Register Button
            Button("Register") {
                if password == confirmPassword && !username.isEmpty {
                    saveUser(username: username, password: password)
                    isRegistrationSuccessful = true // Set to true for success alert
                } else {
                    isRegistrationSuccessful = false // Set to false for failure alert
                }
                showAlert = true // Show the alert based on the result
            }
            // Single alert modifier handling both success and failure
            .alert(isPresented: $showAlert) {
                if isRegistrationSuccessful {
                    return Alert(title: Text("Registration Successful!"), message: Text("Go to Login page now"), dismissButton: .default(Text("OK")))
                } else {
                    return Alert(title: Text("Registration Failed"), message: Text("Passwords do not match or username is empty"), dismissButton: .default(Text("OK")))
                }
            }
        }
        .padding()
    }
    
    // Function to save the user's credentials
    func saveUser(username: String, password: String) {
        UserDefaults.standard.set(username, forKey: "username")
        UserDefaults.standard.set(password, forKey: "password")
    }
}

#Preview {
    RegisterView()
}
