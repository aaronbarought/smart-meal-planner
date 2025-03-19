//
//  NewRecipe.swift
//  RecipeApp
//
//  Created by Aryan Barot on 11/29/24.
//
import SwiftUI
import Firebase

struct NewRecipe: View {
    @State private var name = ""
    @State private var image = ""
    @State private var description = ""
    @State private var ingredients = ""
    @State private var directions = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Recipe Name")) {
                    TextField("Enter recipe name", text: $name)
                }
                
                Section(header: Text("Image URL")) {
                    TextField("Enter image URL (optional)", text: $image)
                        .keyboardType(.URL) // Allows URL input
                }
                
                Section(header: Text("Description")) {
                    TextEditor(text: $description)
                        .frame(height: 100)
                }
                
                Section(header: Text("Ingredients")) {
                    TextEditor(text: $ingredients)
                        .frame(height: 150)
                }
                
                Section(header: Text("Directions")) {
                    TextEditor(text: $directions)
                        .frame(height: 150)
                }
                
                Button(action: saveRecipe) {
                    Text("Save Recipe")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(name.isEmpty || description.isEmpty || ingredients.isEmpty || directions.isEmpty)
            }
            .navigationTitle("Add New Recipe")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Save Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func saveRecipe() {
        guard !name.isEmpty, !description.isEmpty, !ingredients.isEmpty, !directions.isEmpty else {
            alertMessage = "Please fill out all required fields."
            showAlert = true
            return
        }

        let db = Firestore.firestore()
        let recipeData: [String: Any] = [
            "name": name,
            "image": image.isEmpty ? "default_image_url_here" : image, // Use default if empty
            "description": description,
            "ingredients": ingredients,
            "directions": directions
        ]

        db.collection("recipes").addDocument(data: recipeData) { error in
            if let error = error {
                alertMessage = "Error saving recipe: \(error.localizedDescription)"
            } else {
                alertMessage = "Recipe saved successfully!"
                resetForm()
            }
            showAlert = true
        }
    }

    private func resetForm() {
        name = ""
        image = ""
        description = ""
        ingredients = ""
        directions = ""
    }
}
