//
//  FoursquareLocation.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import Foundation

struct FoursquareLocation {
    let coordinate: FoursquareCoordinate?
    let distance: Double?
    let countryCode: String?
    let country: String?
    let state: String?
    let city: String?
    let streetAddress: String?
    let crossStreet: String?
    let postalCode: String?
}

extension FoursquareLocation: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        distance = JSON["distance"] as? Double
        countryCode = JSON["cc"] as? String
        country = JSON["country"] as? String
        state = JSON["state"] as? String
        city = JSON["city"] as? String
        streetAddress = JSON["address"] as? String
        crossStreet = JSON["crossStreet"] as? String
        postalCode = JSON["postalCode"] as? String
        
        if let lat = JSON["lat"] as? Double, let lon = JSON["lng"] as? Double {
            coordinate = FoursquareCoordinate(latitude: lat, longitude: lon)
        } else {
            coordinate = nil
        }
    }
}



