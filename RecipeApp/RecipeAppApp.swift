//
//  RecipeAppApp.swift
//  RecipeApp
//
//  Created by Aryan Barot on 11/29/24.
//

import SwiftUI
import Firebase

@main
struct RecipeAppApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
