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
}

class RestaurantsMapPresenter: RestaurantsMapPresentationLogic {
    
    var viewController: RestaurantsMapDisplayLogic?
    
    func presentRestaurants(venues: [FoursquareVenue]) {
        
    }
    
    func presentError(description: String) {
        
    }
}
