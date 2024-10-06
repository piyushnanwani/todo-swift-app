//
//  APIExampleView.swift
//  TodoList
//
//  Created by Piyush Nanwani on 06/10/24.
//

import SwiftUI

struct APIExampleView: View {
    @State private var endpoint: String = "https://jsonplaceholder.typicode.com/posts/1" // Default URL
    @State private var responseData: String = "" // Holds the fetched data
    @State private var errorMessage: String = "" // Holds any error messages
    
    var body: some View {
        VStack {
            // TextField to edit the endpoint URL
            TextField("API Endpoint", text: $endpoint)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Button to initiate the API call
            Button("Get Data") {
                fetchData()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            // Display response data or error message
            ScrollView {
                if !responseData.isEmpty {
                    Text("Response Data:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text(responseData)
                        .padding()
                } else if !errorMessage.isEmpty {
                    Text("Error:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text(errorMessage)
                        .padding()
                        .foregroundColor(.red)
                }
            }
            .padding()
        }
        .padding()
        .navigationTitle("API Example")
    }
    
    // Function to fetch data from the API
    private func fetchData() {
        // Validate URL
        guard let url = URL(string: endpoint) else {
            errorMessage = "Invalid URL."
            responseData = ""
            return
        }
        
        // Clear previous messages
        responseData = ""
        errorMessage = ""
        
        // Create a URL session data task
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle errors
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Request failed: \(error.localizedDescription)"
                }
                return
            }
            
            // Handle response data
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self.responseData = dataString
                }
            } else {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to get valid response."
                }
            }
        }.resume() // Start the network call
    }
}

#Preview {
    APIExampleView()
}
