//
//  Home.swift
//  RecipeApp
//
//  Created by Aryan Barot on 11/29/24.
import SwiftUI

struct Home: View {
    @StateObject private var firebaseService = FirebaseService()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                Text("My Recipes")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)

                Text("\(firebaseService.recipes.count) recipes")
                    .font(.subheadline)
                    .padding(.horizontal)
                    .foregroundColor(.gray)

                if let errorMessage = firebaseService.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if firebaseService.recipes.isEmpty {
                    Text("No recipes available.")
                        .font(.headline)
                        .padding()
                } else {
                    List {
                        ForEach(firebaseService.recipes, id: \.id) { recipe in
                            NavigationLink(destination: RecipeView(recipe: recipe)) {
                                RecipeTile(recipe: recipe)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    deleteRecipe(recipe)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationBarTitle("Recipes", displayMode: .inline)
            .onAppear {
                firebaseService.fetchRecipes { _ in
                    
                }
            }
        }
    }

    private func deleteRecipe(_ recipe: Recipe) {
        firebaseService.deleteRecipe(recipe) { success in
            if success {
                print("Recipe deleted successfully.")
            } else {
                print("Failed to delete recipe.")
            }
        }
    }
}
