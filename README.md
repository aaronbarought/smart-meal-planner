# smart-meal-planner
A SwiftUI-based meal planning app with Firebase integration for scheduling meals, grocery list management, and store locator functionality.

## Features
✅ Schedule and manage meal plans  
✅ Generate grocery lists from selected recipes  
✅ Find nearby grocery stores using **MapKit**  
✅ Recipe recommendations based on dietary preferences  
✅ Secure **Firebase Authentication**


## 📂 Code Structure

### **1️⃣ Main App Files**
- **`RecipeApp/RecipeAppApp.swift`**  
  - The **entry point** of the app.  
  - Initializes the **SwiftUI environment and views**.

### **2️⃣ Views & UI Components**
- **`RecipeApp/Main/ContentView.swift`**  
  - The **main screen** displaying meal plans and recipe suggestions.
- **`RecipeApp/Main/Home.swift`**  
  - The **home screen** where users interact with recipes and meal tracking.
- **`RecipeApp/Main/Settings.swift`**  
  - The settings screen for managing user preferences.
- **`RecipeApp/Main/Tabbar.swift`**  
  - Handles **navigation** between different app sections.
- **`RecipeApp/Comoponents/RecipeCombine.swift`**  
  - Manages the combination of ingredients and meal categories.
- **`RecipeApp/Comoponents/RecipeTile.swift`**  
  - UI component for displaying individual recipe tiles.

### **3️⃣ Data Management & Firebase Integration**
- **`RecipeApp/Main/FirebaseService.swift`**  
  - Handles **Firebase authentication** and **database interactions**.
- **`RecipeApp/Main/GoogleService-Info.plist`**  
  - Stores **Firebase project configurations** (API keys, database info).
- **`RecipeApp/DataModel/Data.swift`**  
  - Defines **data structures** for storing and processing meal/recipe data.

### **4️⃣ Assets & Design**
- **`RecipeApp/Assets.xcassets/`**  
  - Stores **images, icons, and design assets**.
- **`RecipeApp/Preview Content/Preview Assets.xcassets/`**  
  - Contains **preview assets** for Xcode’s UI previews.

### **5️⃣ Database & Model Layer**
- **`RecipeApp/RecipeApp.xcdatamodeld/RecipeApp.xcdatamodel`**  
  - Defines the **Core Data model** for storing meal plans and user preferences.

### **6️⃣ Testing & Debugging**
- **`RecipeAppTests/RecipeAppTests.swift`**  
  - Contains **unit tests** for meal planning logic.
- **`RecipeAppUITests/RecipeAppUITests.swift`**  
  - UI tests to validate app functionality.

### **7️⃣ Project Configuration**
- **`RecipeApp.xcodeproj/`**  
  - The main **Xcode project configuration files**.
- **`RecipeApp.xcodeproj/project.xcworkspace/`**  
  - Stores Xcode **workspace settings and dependencies**.


## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/aaronbarought/smart-meal-planner.git
