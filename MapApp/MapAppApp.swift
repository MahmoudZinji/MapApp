//
//  MapAppApp.swift
//  MapApp
//
//  Created by Mahmoud Zinji on 2022-05-16.
//

import SwiftUI

@main
struct MapAppApp: App {

    @State private var vm = LocationsViewModel()

    var body: some Scene {
        WindowGroup {
            LocationsViews()
                .environmentObject(vm)
        }
    }
}
