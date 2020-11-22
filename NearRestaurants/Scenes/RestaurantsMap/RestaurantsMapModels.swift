//
//  RestaurantsMapModels.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/22/20.
//

import Foundation

enum RestaurantsMap {
    
    enum Venues {
        struct Request {
            var latitude: Double
            var longitude: Double
        }
        
        struct Response {
            var restaurants: [FoursquareVenue]
            var errorMessage: Error? = nil
        }
        
        struct ViewModel {
            var restaurants: [FoursquareVenue]
        }
        
        struct ErrorViewModel {
            var errorDescription: String
        }
    }
    
    enum GetVenueDetail {
        struct Request {
            var venueName: String?
        }
        
        struct Response {
            var venueInfo: FoursquareVenue
        }
        
        struct ViewModel {
            var venueInfo: FoursquareVenue
        }
    }
}
