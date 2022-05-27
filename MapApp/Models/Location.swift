//
//  Location.swift
//  MapApp
//
//  Created by Mahmoud Zinji on 2022-05-16.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Equatable {

    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String

    var id: String {
        name + cityName
    }

    // Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
