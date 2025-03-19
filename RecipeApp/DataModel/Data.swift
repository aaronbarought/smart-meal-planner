//
//  Data.swift
//  RecipeApp
//
//  Created by Aryan Barot on 11/29/24.
//
import Foundation

struct Recipe: Identifiable {
    let id: String
    let name: String
    let description: String
    let ingredients: String
    let directions: String
    let image: String
}
