//
//  RestaurantsMapPresenter.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import Foundation

protocol RestaurantsMapPresentationLogic {
    func presentRestaurants(venues: [FoursquareVenue])
    func presentError(description: String)
    func presentDetails(of venue: FoursquareVenue)
}

class RestaurantsMapPresenter: RestaurantsMapPresentationLogic {
    
    var viewController: RestaurantsMapDisplayLogic?
    
    func presentRestaurants(venues: [FoursquareVenue]) {
        viewController?.displayRestaurants(venues: venues)
    }
    
    func presentError(description: String) {
        if description == "" {
            viewController?.displayErrorPopup(with: "Could not load the restaurants")
        } else {
            viewController?.displayErrorPopup(with: description)
        }
    }
    
    func presentDetails(of venue: FoursquareVenue) {
        viewController?.displayVenueDetails(venue: venue)
    }
}
