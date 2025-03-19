//
//  Favorites.swift
//  RecipeApp
//
//  Created by Aryan Barot on 11/29/24.
//
import SwiftUI
import MapKit

struct Favorites: View {
    @State private var zipCode: String = ""
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default to San Francisco
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var groceryStores: [GroceryStore] = []

    var body: some View {
        NavigationView {
            VStack {
                // Zip Code
                HStack {
                    TextField("Enter ZIP Code", text: $zipCode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding(.horizontal)
                    
                    Button(action: {
                        searchNearbyGroceryStores()
                    }) {
                        Text("Search")
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.top)

                // Grocery Stores
                Map(coordinateRegion: $region, annotationItems: groceryStores) { store in
                    MapAnnotation(coordinate: store.coordinate) {
                        VStack {
                            Image(systemName: "cart.fill")
                                .foregroundColor(.red)
                                .font(.title)
                            Text(store.name)
                                .font(.caption)
                                .fixedSize(horizontal: true, vertical: false)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("Nearby Grocery Stores")
        }
    }

    // MARK: - Search for Nearby Grocery Stores
    private func searchNearbyGroceryStores() {
        guard !zipCode.isEmpty else { return }

        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(zipCode) { placemarks, error in
            if let error = error {
                print("Geocoding failed: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first, let location = placemark.location else {
                print("No location found for ZIP Code.")
                return
            }
            
            let coordinate = location.coordinate
            region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = "Grocery Store"
            request.region = region

            let search = MKLocalSearch(request: request)
            search.start { response, error in
                if let error = error {
                    print("Search failed: \(error.localizedDescription)")
                    return
                }

                guard let mapItems = response?.mapItems else {
                    print("No results found.")
                    return
                }

                groceryStores = mapItems.map { item in
                    GroceryStore(
                        name: item.name ?? "Unknown",
                        coordinate: item.placemark.coordinate
                    )
                }
            }
        }
    }
}

// MARK: - Grocery Store Data Model
struct GroceryStore: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
