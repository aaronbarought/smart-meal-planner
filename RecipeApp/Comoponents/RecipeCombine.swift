//
//  RecipeCombine.swift
//  RecipeApp
//
//  Created by Aryan Barot on 11/29/24.
//
import SwiftUI

struct RecipeCombine: View {
    var recipes: [Recipe]

    let columns = [
        GridItem(.adaptive(minimum: 170), spacing: 15)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(recipes) { recipe in
                NavigationLink(destination: RecipeView(recipe: recipe)) {
                    RecipeTile(recipe: recipe)
                }
            }
        }
        .padding(.horizontal)
    }
}
