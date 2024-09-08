//
//  LocationService.swift
//  Places
//
//  Created by Dennis van Oosten on 05/09/2024.
//

import Foundation

class LocationService {
    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchLocations(completion: @escaping (Result<LocationsModel, Error>) -> Void) {
        let urlString = "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        // Create a task to fetch data from the URL
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            // Decode the fetched data using the JSONDecoder
            do {
                let decoder = JSONDecoder()
                let locationsResponse = try decoder.decode(LocationsModel.self, from: data)
                completion(.success(locationsResponse))
            } catch {
                completion(.failure(error))
            }
        }
            
        task.resume()
    }
}
