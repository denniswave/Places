//
//  AddPlaceView.swift
//  Places
//
//  Created by Dennis van Oosten on 08/09/2024.
//

import SwiftUI
import SwiftData

struct AddPlaceView: View {
    @State private var name: String = ""
    @State private var lat: Double?
    @State private var long: Double?
        
    // Formatter to convert string to double and vice versa
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 6
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }
                
                Section(header: Text("Coordinates")) {
                    TextField("Latitude", value: $lat, formatter: numberFormatter)
                        .keyboardType(.decimalPad)
                    
                    TextField("Longitude", value: $long, formatter: numberFormatter)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationBarTitle("Add place")
        }
    }
}

#Preview {
    AddPlaceView()
}
