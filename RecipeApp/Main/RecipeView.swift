//
//  RecipeView.swift
//  RecipeApp
//
//  Created by Aryan Barot on 11/29/24.
//
import SwiftUI

struct RecipeView: View {
    var recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: recipe.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 140)
                        .clipped()
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 70)
                        .foregroundColor(.gray)
                }

                Text(recipe.name)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.top)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Description")
                        .font(.headline)
                    Text(recipe.description)
                        .font(.body)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Ingredients")
                        .font(.headline)
                    Text(recipe.ingredients)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("Directions")
                        .font(.headline)
                    Text(recipe.directions)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding()
        }
        .navigationTitle("Recipe Details")
    }
}
