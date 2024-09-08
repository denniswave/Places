//
//  WikipediaService.swift
//  Places
//
//  Created by Dennis van Oosten on 08/09/2024.
//

import Foundation
import UIKit

class WikipediaService {
    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func openWikipedia(onLatitude lat: Double, longitude long: Double) {
        let urlString = "wikipedia://places?WMFLatitude=\(lat)&WMFLongitude=\(long)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        UIApplication.shared.open(url, options: [:]) { (success) in
            if success {
                print("Deep link opened successfully.")
            } else {
                print("Failed to open deep link.")
            }
        }
    }
}
