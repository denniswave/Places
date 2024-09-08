//
//  AddLocationView.swift
//  Places
//
//  Created by Dennis van Oosten on 08/09/2024.
//

import SwiftUI
import SwiftData

struct AddLocationView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var lat: String = ""
    @State private var long: String = ""
    
    var canSave: Bool {
        return !lat.isEmpty && !long.isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                        .accessibilityLabel("Location name")
                        .accessibilityHint("Enter the name of the location (optional).")
                }
                
                Section(header: Text("Coordinates")) {
                    TextField("Latitude", text: $lat)
                        .keyboardType(.decimalPad)
                        .accessibilityLabel("Latitude")
                        .accessibilityHint("Enter the latitude in decimal format. For example, 52.35.")
                    
                    TextField("Longitude", text: $long)
                        .keyboardType(.decimalPad)
                        .accessibilityLabel("Longitude")
                        .accessibilityHint("Enter the longitude in decimal format. For example, 4.83.")
                }
            }
            .navigationBarTitle("Add location")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        savePlace()
                    } label: {
                        Text("Save")
                    }
                    .disabled(!canSave)
                    .accessibilityLabel("Save Location")
                    .accessibilityHint("Double tap to save the new location.")
                }
            }
        }
        .accessibilityLabel("Add location view")
        .accessibilityHint("Use this view to add a new location by entering its name and coordinates.")
    }
    
    private func savePlace() {
        // Use the number formatter to convert strings to numbers
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        
        let latNumber = formatter.number(from: lat)
        let longNumber = formatter.number(from: long)
        
        guard let lat = latNumber?.doubleValue, let long = longNumber?.doubleValue else { return }
        
        // Create and save a new place
        let name = self.name.isEmpty ? nil : self.name
        let newLocation = LocationModel(name: name, lat: lat, long: long)
        modelContext.insert(newLocation)
        
        // Dismiss the view
        dismiss()
    }
}

#Preview {
    AddLocationView()
}
