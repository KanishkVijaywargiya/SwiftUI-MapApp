//
//  Location.swift
//  MapAppSwiftFull
//
//  Created by KANISHK VIJAYWARGIYA on 07/01/22.
//

import Foundation
import MapKit

/// Equatable : if we have 2 different locations in our code, how does the compiler differentiate, how can we set one location equal to another location, so the compiler wants to know are these 2 locations are equal or not equal (same thing or differerent)

struct Location: Identifiable, Equatable {
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    // computed variable
    var id: String {
        name + cityName
    }
    
    // equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
