//
//  FirebaseService.swift
//  RecipeApp
//
//  Created by Aryan Barot on 11/30/24.
//
import Firebase
import Foundation

class FirebaseService: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String?

    private let db = Firestore.firestore()
    func fetchRecipes(completion: @escaping ([Recipe]) -> Void) {
        db.collection("recipes").getDocuments { snapshot, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error fetching recipes: \(error.localizedDescription)"
                }
                completion([])
                return
            }

            guard let documents = snapshot?.documents else {
                DispatchQueue.main.async {
                    self.errorMessage = "No recipes found in Firebase."
                }
                completion([])
                return
            }

            let fetchedRecipes = documents.compactMap { doc -> Recipe? in
                let data = doc.data()
                return Recipe(
                    id: doc.documentID,
                    name: data["name"] as? String ?? "",
                    description: data["description"] as? String ?? "",
                    ingredients: data["ingredients"] as? String ?? "",
                    directions: data["directions"] as? String ?? "",
                    image: data["image"] as? String ?? ""
                )
            }

            DispatchQueue.main.async {
                self.recipes = fetchedRecipes
                completion(fetchedRecipes)
            }
        }
    }

    // Deletes a recipe from Firebase
    func deleteRecipe(_ recipe: Recipe, completion: @escaping (Bool) -> Void) {
        db.collection("recipes").document(recipe.id).delete { error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error deleting recipe: \(error.localizedDescription)"
                }
                completion(false)
                return
            }
            DispatchQueue.main.async {
                self.recipes.removeAll { $0.id == recipe.id } 
                completion(true)
            }
        }
    }
}
