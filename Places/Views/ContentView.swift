//
//  ContentView.swift
//  Places
//
//  Created by Dennis van Oosten on 05/09/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject private var viewModel = LocationViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.locations) { location in
                    Button {
                        WikipediaService().openWikipedia(onLatitude: location.lat, longitude: location.long)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(location.name ?? "Unknown")
                                .font(.headline)
                            HStack {
                                Text("\(location.lat)")
                                Text("\(location.long)")
                            }
                            .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Places")
            .onAppear {
                viewModel.fetchLocations()
            }
            .alert(item: $viewModel.errorWrapper) { errorWrapper in
                Alert(title: Text("Error"), message: Text(errorWrapper.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    ContentView()
}
