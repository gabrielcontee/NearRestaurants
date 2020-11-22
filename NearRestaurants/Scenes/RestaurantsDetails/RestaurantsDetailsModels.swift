//
//  RestaurantsDetailsModels.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conte on 11/22/20.
//

import Foundation

typealias ImageName = String
typealias Info = String

enum RestaurantsDetail {
    
    enum GetInfo {
        
        struct Request {}
        
        struct Response {
            let venue: FoursquareVenue
        }
        
        struct ViewModel {
            let venueImageInfoList: [VenueDetailsCellModel]
        }
    }
}
