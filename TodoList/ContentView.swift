//
//  ContentView.swift
//  TodoList
//
//  Created by Piyush Nanwani on 17/09/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var todos: [String] = []
    @State private var newTodo: String = ""
    

    
    var body: some View {
        VStack {
            TextField("New Todo", text: $newTodo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: {
                // if newTodo is not empty
                // then add the newItem to my list
                
                if !newTodo.isEmpty {
                    todos.append(newTodo)
                    newTodo = ""
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
            
            List {
                ForEach(todos, id: \.self) {
                    todo in Text(todo)
                }
            }
            
        }
        .padding()
    
        
    }
      
    
    
}

#Preview {
    ContentView()
}
