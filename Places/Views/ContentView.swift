//
//  ContentView.swift
//  Places
//
//  Created by Dennis van Oosten on 05/09/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var viewModel = LocationViewModel()
    @Query private var storedLocations: [LocationModel]
    
    @State private var isAddPlaceViewPresented: Bool = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(viewModel.locations) { location in
                        LocationButton(location: location)
                    }
                }
                
                Section("My places") {
                    ForEach(storedLocations) { location in
                        LocationButton(location: location)
                    }
                }
            }
            .navigationTitle("Places")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isAddPlaceViewPresented = true
                    } label: {
                        Label("Add place", systemImage: "plus")
                           
                    }
                    .accessibilityLabel("Add a new place")
                    .accessibilityHint("Double tap to add a new place to the list.")
                }
            }
            .onAppear {
                viewModel.fetchLocations()
            }
            .sheet(isPresented: $isAddPlaceViewPresented) {
                AddLocationView()
            }
            .alert(item: $viewModel.errorWrapper) { errorWrapper in
                Alert(title: Text("Error"), message: Text(errorWrapper.message), dismissButton: .default(Text("OK")))
            }
        }
        .accessibilityLabel("Places list")
        .accessibilityHint("List of locations and a button to add a new one. Double tap on a location to open its Wikipedia page.")
    }
}

#Preview {
    ContentView()
}
