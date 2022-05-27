//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Mahmoud Zinji on 2022-05-16.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {

    // All loaded locations
    @Published var locations: [Location]

    // Current location on map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }

    // Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

    // Show list of locations
    @Published var showLocationsList: Bool = false

    // Show Location Detail Via Sheet
    @Published var sheetLocation: Location? = nil

    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }

    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan
            )
        }
    }

    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }

    func showNextLocation(_ location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }

    func nextButtonClicked() {
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("Could not find current index in location array")
            return
        }

        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            showNextLocation(locations.first!)
            return
        }

        showNextLocation(locations[nextIndex])
    }
}

