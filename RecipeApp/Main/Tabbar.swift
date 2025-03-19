//
//  TabBar.swift
//  RecipeApp
//
//  Created by Aryan Barot on 11/29/24.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            NewRecipe()
                .tabItem {
                    Label("New", systemImage: "plus")
                }
            Categories()
                .tabItem {
                    Label("Grocery List", systemImage: "cart")
                }
            Favorites()
                .tabItem {
                    Label("Nearby Stores", systemImage: "mappin.and.ellipse")
                }
        }
    }
}
