import SwiftUI

struct ContentView: View {
    @Binding var isAuthenticated: Bool // Binding to change the authentication state
    @State private var todos: [String] = [] // Holds list of ToDos
    @State private var newTodo: String = "" // Holds the input for a new ToDo item
    
    var body: some View {
        NavigationView {
            VStack {
                // Input Field for New ToDo
                TextField("New Todo", text: $newTodo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Add Button
                Button(action: {
                    if !newTodo.isEmpty {
                        todos.append(newTodo) // Adds new item to the list
                        newTodo = "" // Clears the input field
                    }
                }) {
                    Text("Add Todo")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // List of Todos
                List {
                    ForEach(todos, id: \.self) { todo in
                        Text(todo) // Displays each ToDo item
                    }
                }
            }
            .padding()
            .navigationTitle("ToDo List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // Logout Button
                    Button(action: {
                        isAuthenticated = false // Sets state to false without deleting credentials
                    }) {
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(isAuthenticated: .constant(true))
}
