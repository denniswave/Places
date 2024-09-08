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
    
    @State private var isAddPlaceViewPresented: Bool = false

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
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isAddPlaceViewPresented = true
                    } label: {
                        Label("Add place", systemImage: "plus")
                    }
                }
            }
            .onAppear {
                viewModel.fetchLocations()
            }
            .sheet(isPresented: $isAddPlaceViewPresented) {
                AddPlaceView()
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
