//
//  AddPlaceView.swift
//  Places
//
//  Created by Dennis van Oosten on 08/09/2024.
//

import SwiftUI
import SwiftData

struct AddPlaceView: View {
    @Environment(\.modelContext) private var modelContext: ModelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var lat: String = ""
    @State private var long: String = ""
        
    // Formatter to convert string to double and vice versa
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 6
        return formatter
    }()
    
    var canSave: Bool {
        return !lat.isEmpty && !long.isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }
                
                Section(header: Text("Coordinates")) {
                    TextField("Latitude", text: $lat)
                        .keyboardType(.decimalPad)
                    
                    TextField("Longitude", text: $long)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationBarTitle("Add place")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        savePlace()
                    } label: {
                        Text("Save")
                    }
                    .disabled(!canSave)
                }
            }
        }
    }
    
    private func savePlace() {
        // Use the number formatter to convert the strings to numbers
        let latNumber = numberFormatter.number(from: lat)
        let longNumber = numberFormatter.number(from: long)
        
        guard let lat = latNumber?.doubleValue, let long = longNumber?.doubleValue else { return }
        
        // Create and save a new place
        let name = self.name.isEmpty ? nil : self.name
        let newLocation = LocationModel(name: name, lat: lat, long: long)
        modelContext.insert(newLocation)
        
        dismiss()
    }
}

#Preview {
    AddPlaceView()
}
