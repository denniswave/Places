//
//  MockLocationService.swift
//  Places
//
//  Created by Dennis van Oosten on 05/09/2024.
//

import Foundation

class MockLocationService: LocationService {
    var result: Result<LocationsModel, Error>?
    
    override func fetchLocations(completion: @escaping (Result<LocationsModel, Error>) -> Void) {
        if let result = result {
            completion(result)
        }
    }
}
