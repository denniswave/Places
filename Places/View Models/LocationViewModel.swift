//
//  LocationViewModel.swift
//  Places
//
//  Created by Dennis van Oosten on 05/09/2024.
//

import SwiftUI

class LocationViewModel: ObservableObject {
    @Published var locations: [LocationModel] = []
    @Published var errorWrapper: ErrorWrapper?
    
    private let locationService: LocationService
        
    init(locationService: LocationService = LocationService()) {
        self.locationService = locationService
    }

    func fetchLocations() {
        locationService.fetchLocations { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let locationsResponse):
                    self.locations = locationsResponse.locations
                case .failure(let error):
                    self.errorWrapper = ErrorWrapper(message: "Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
