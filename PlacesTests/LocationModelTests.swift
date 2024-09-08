//
//  LocationModelTests.swift
//  PlacesTests
//
//  Created by Dennis van Oosten on 05/09/2024.
//

import XCTest
@testable import Places

class LocationModelTests: XCTestCase {
    func testDecodingLocationSuccess() throws {
        // Given
        let jsonData = """
        {
            "locations": [
                {
                  "name": "Amsterdam",
                  "lat": 52.3547498,
                  "long": 4.8339215
                }
            ]
        }
        """.data(using: .utf8)!

        // When
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(LocationsResponseModel.self, from: jsonData)
            
            // Then
            XCTAssertEqual(response.locations.count, 1)
            XCTAssertEqual(response.locations.first?.name, "Amsterdam")
            XCTAssertEqual(response.locations.first?.lat, 52.3547498)
            XCTAssertEqual(response.locations.first?.long, 4.8339215)
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
    
    func testDecodingLocationSuccessWhenNameIsMissing() throws {
        // Given
        let jsonData = """
        {
            "locations": [
                {
                  "lat": 52.3547498,
                  "long": 4.8339215
                }
            ]
        }
        """.data(using: .utf8)!

        // When
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(LocationsResponseModel.self, from: jsonData)
            
            // Then
            XCTAssertEqual(response.locations.count, 1)
            XCTAssertEqual(response.locations.first?.name, nil)
            XCTAssertEqual(response.locations.first?.lat, 52.3547498)
            XCTAssertEqual(response.locations.first?.long, 4.8339215)
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
}

