//
//  LocationViewModelTests.swift
//  PlacesTests
//
//  Created by Dennis van Oosten on 05/09/2024.
//

import XCTest
@testable import Places

class LocationViewModelTests: XCTestCase {
    var mockService: MockLocationService!
    var viewModel: LocationViewModel!

    override func setUpWithError() throws {
        super.setUp()
        
        mockService = MockLocationService()
        viewModel = LocationViewModel(locationService: mockService)
    }
    
    override func tearDownWithError() throws {
        mockService = nil
        viewModel = nil
    }

    func testFetchLocationsSuccess() throws {
        // Given
        let sampleLocations = [
            LocationModel(name: "Amsterdam", lat: 52.3547498, long: 4.8339215),
            LocationModel(name: "Mumbai", lat: 19.0823998, long: 72.8111468),
            LocationModel(name: "Copenhagen", lat: 55.6713442, long: 12.523785),
            LocationModel(name: nil, lat: 40.4380638, long: -3.7495758)
        ]
        let response = LocationsResponseModel(locations: sampleLocations)
        mockService.result = .success(response)
        
        let expectation = XCTestExpectation(description: "Fetch locations succeeds")
        
        // When
        viewModel.fetchLocations()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.locations.count, 4)
            XCTAssertNil(self.viewModel.errorWrapper)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchLocationsNoDataReceived() throws {
        // Given
        mockService.result = .success(LocationsResponseModel(locations: []))
        
        let expectation = XCTestExpectation(description: "Fetch locations succeeds with no data received")
        
        // When
        viewModel.fetchLocations()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.viewModel.locations.isEmpty)
            XCTAssertNil(self.viewModel.errorWrapper)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchLocationsFailure() throws {
        // Given
        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch data"])
        mockService.result = .failure(error)
        
        let expectation = XCTestExpectation(description: "Fetch locations fails")
        
        // When
        viewModel.fetchLocations()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewModel.errorWrapper)
            XCTAssertEqual(self.viewModel.errorWrapper?.message, "Error: Failed to fetch data")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
