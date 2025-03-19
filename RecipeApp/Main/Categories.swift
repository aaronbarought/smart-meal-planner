//
//  CategoriesView.swift
//  RecipeApp
//
//  Created by Aryan Barot on 11/29/24.
//
import SwiftUI

struct Categories: View {
    @State private var groceryList: [GroceryItem] = []
    @State private var isAddingRecipe = false
    @State private var recipes: [Recipe] = []
    
    var body: some View {
        NavigationView {
            VStack {
                
                List {
                    Section(header: Text("Grocery List")) {
                        ForEach($groceryList) { $item in
                            HStack {
                                Text(item.name)
                                    .strikethrough(item.isPurchased, color: .black)
                                    .foregroundColor(item.isPurchased ? .gray : .primary)
                                Spacer()
                                if !item.isPurchased {
                                    Button(action: {
                                        item.isPurchased.toggle()
                                    }) {
                                        Image(systemName: "checkmark.circle")
                                            .foregroundColor(.green)
                                    }
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                item.isPurchased.toggle()
                            }
                        }
                        .onDelete(perform: deleteGroceryItem)
                    }
                }
                
                
                Button(action: {
                    isAddingRecipe = true
                }) {
                    Text("Add Recipe Ingredients")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
            }
            .navigationTitle("Grocery List")
        }
        .sheet(isPresented: $isAddingRecipe) {
            
            NavigationView {
                List(recipes, id: \.id) { recipe in
                    Button(action: {
                        addIngredients(from: recipe)
                        isAddingRecipe = false
                    }) {
                        VStack(alignment: .leading) {
                            Text(recipe.name)
                                .font(.headline)
                            Text("Add ingredients")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .navigationTitle("Select a Recipe")
            }
        }
        .onAppear {
            fetchRecipes() 
        }
    }
    
    // MARK: - Functions
    
    private func deleteGroceryItem(at offsets: IndexSet) {
        groceryList.remove(atOffsets: offsets)
    }
    
    private func addIngredients(from recipe: Recipe) {
        let ingredients = recipe.ingredients.split(separator: "•").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
        let newItems = ingredients.map { GroceryItem(name: $0, isPurchased: false) }
        groceryList.append(contentsOf: newItems)
    }
    
    private func fetchRecipes() {
        let firebaseService = FirebaseService()
        firebaseService.fetchRecipes { fetchedRecipes in
            DispatchQueue.main.async {
                self.recipes = fetchedRecipes
            }
        }
    }
}

// MARK: - Data Models

struct GroceryItem: Identifiable {
    let id = UUID()
    var name: String
    var isPurchased: Bool
}
