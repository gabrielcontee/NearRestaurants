//
//  RestaurantsDetailsInteractor.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/22/20.
//

import Foundation

protocol RestaurantsDetailsBusinessLogic {
    func fetchVenueDetails(request: RestaurantsDetail.GetInfo.Request)
}

protocol RestaurantsDetailsDataStore {
    var venueInfo: FoursquareVenue? { get set }
}

class RestaurantsDetailsInteractor: RestaurantsDetailsBusinessLogic, RestaurantsDetailsDataStore {
    
    var presenter: RestaurantsDetailsPresentationLogic?
    
    var venueInfo: FoursquareVenue?
    
    func fetchVenueDetails(request: RestaurantsDetail.GetInfo.Request) {
        guard let information = venueInfo else {
            return
        }
        let response = RestaurantsDetail.GetInfo.Response(venue: information)
        presenter?.presentVenueDetails(response: response)
    }
}
