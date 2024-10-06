import SwiftUI
import CoreData

struct ContentView: View {
    @Binding var isAuthenticated: Bool // Binding to change the authentication state
    
    @Environment(\.managedObjectContext) private var viewContext // Access Core Data context
    
    // Fetch the Todo items from Core Data, sorted by timestamp
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TodoItem.timestamp, ascending: true)],
        animation: .default
    ) private var todos: FetchedResults<TodoItem>
    
    @State private var newTodo: String = "" // Holds the input for a new ToDo item
    
    var body: some View {
        NavigationView {
            VStack {
                // Input Field for New ToDo
                TextField("New Todo", text: $newTodo)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Add Button
                Button(action: addTodo) {
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
                    ForEach(todos) { todo in
                        Text(todo.title ?? "Untitled") // Displays each ToDo item
                    }
                    .onDelete(perform: deleteTodo) // Allow deletion of todos
                }
            }
            .padding()
            .navigationTitle("ToDo List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    // Logout Button
                    Button(action: {
                        isAuthenticated = false // Sets state to false without deleting credentials
                        UserDefaults.standard.set(false, forKey: "isAuthenticated") // Update UserDefaults

                    }) {
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton() // Enable editing (deletion) in the list
                }
            }
        }
    }
    
    // Function to add a new ToDo item to Core Data
    private func addTodo() {
        withAnimation {
            let newTodoItem = TodoItem(context: viewContext)
            newTodoItem.id = UUID() // Set unique ID
            newTodoItem.title = newTodo // Set the title of the new todo
            newTodoItem.timestamp = Date() // Set timestamp
            
            do {
                try viewContext.save() // Save to Core Data
                newTodo = "" // Clear input field after saving
            } catch {
                print("Failed to save new ToDo: \(error.localizedDescription)")
            }
        }
    }
    
    // Function to delete a ToDo item from Core Data
    private func deleteTodo(offsets: IndexSet) {
        withAnimation {
            offsets.map { todos[$0] }.forEach(viewContext.delete) // Delete selected items
            
            do {
                try viewContext.save() // Save changes after deletion
            } catch {
                print("Failed to delete ToDo: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ContentView(isAuthenticated: .constant(true))
}
