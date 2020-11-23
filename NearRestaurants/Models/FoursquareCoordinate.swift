//
//  FoursquareFoursquareCoordinate.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import Foundation

struct FoursquareCoordinate: CustomStringConvertible, Hashable {
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var description: String {
        return "\(latitude),\(longitude)"
    }
}
