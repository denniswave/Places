//
//  LocationModel.swift
//  Places
//
//  Created by Dennis van Oosten on 05/09/2024.
//

import Foundation
import SwiftData

@Model
final class LocationModel: Decodable {
    @Attribute(.unique) var id: UUID
    var name: String?
    var lat: Double
    var long: Double
    
    init(name: String? = nil, lat: Double, long: Double) {
        // Generate a new UUID
        self.id = UUID()
        
        self.name = name
        self.lat = lat
        self.long = long
    }
    
    // Custom coding keys to exclude 'id' from decoding
    private enum CodingKeys: String, CodingKey {
        case name, lat, long
    }
    
    // Custom initializer for Decodable
    required init(from decoder: Decoder) throws {
        // Generate a new UUID when decoding
        self.id = UUID()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.lat = try container.decode(Double.self, forKey: .lat)
        self.long = try container.decode(Double.self, forKey: .long)
    }
}
