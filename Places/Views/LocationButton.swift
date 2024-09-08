//
//  LocationButton.swift
//  Places
//
//  Created by Dennis van Oosten on 08/09/2024.
//

import Foundation
import SwiftUI

struct LocationButton: View {
    var location: LocationModel
    
    var body: some View {
        Button {
            WikipediaService().openWikipedia(onLatitude: location.lat, longitude: location.long)
        } label: {
            HStack(spacing: 16) {
                Image(systemName: (location.name != nil) ? "globe.desk.fill" : "globe.desk")
                    .accessibilityHidden(true)
                
                VStack(alignment: .leading) {
                    Text(location.name ?? "Unknown")
                        .font(.headline)
                        .accessibilityLabel("Location name")
                        .accessibilityValue(location.name ?? "Unknown")
                    
                    HStack(spacing: 16) {
                        HStack {
                            Text("lat:")
                            Text(String(format: "%.6f", location.lat))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        .accessibilityLabel("Latitude")
                        .accessibilityValue(String(format: "%.6f", location.lat))
                        
                        HStack {
                            Text("long:")
                            Text(String(format: "%.6f", location.long))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        .accessibilityLabel("Longitude")
                        .accessibilityValue(String(format: "%.6f", location.long))
                    }
                    .font(.subheadline)
                }
            }
        }
        .foregroundStyle(Color.primary)
        .accessibilityLabel("Open Wikipedia for \(location.name ?? "unknown location")")
        .accessibilityHint("Double tap to open Wikipedia page")
    }
}

#Preview {
    let amsterdam = LocationModel(name: "Amsterdam", lat: 52.3547498, long: 4.8339215)
    let unknown = LocationModel(name: nil, lat: 52.3547498, long: 4.8339215)
    
    return VStack(spacing: 24) {
        LocationButton(location: amsterdam)
        LocationButton(location: unknown)
    }
}
