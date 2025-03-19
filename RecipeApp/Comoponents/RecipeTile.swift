//
//  RecipeTile.swift
//  RecipeApp
//
//  Created by Aryan Barot on 11/29/24.
//
import SwiftUI

struct RecipeTile: View {
    var recipe: Recipe

    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: recipe.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200) // Adjust height as needed
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0.7), .clear]),
                startPoint: .bottom,
                endPoint: .top
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))

            
            Text(recipe.name)
                .font(.headline)
                .foregroundColor(.white)
                .padding([.horizontal, .bottom], 10)
        }
        .frame(height: 200) 
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
    }
}
