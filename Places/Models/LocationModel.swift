//
//  LocationModel.swift
//  Places
//
//  Created by Dennis van Oosten on 05/09/2024.
//

import Foundation

struct LocationModel: Identifiable, Codable {
    var id: UUID = UUID()
    
    var name: String?
    var lat: Double
    var long: Double
    
    // Custom coding keys to exclude 'id' from decoding
    private enum CodingKeys: String, CodingKey {
        case name, lat, long
    }
}
