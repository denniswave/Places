//
//  PlacesApp.swift
//  Places
//
//  Created by Dennis van Oosten on 05/09/2024.
//

import SwiftUI
import SwiftData

@main
struct PlacesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            LocationModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            PlacesView()
        }
        .modelContainer(sharedModelContainer)
    }
}
