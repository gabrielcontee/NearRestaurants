//
//  RestaurantsDetailsInteractor.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/22/20.
//

import Foundation

protocol RestaurantsDetailsBusinessLogic {
    
}

protocol RestaurantsDetailsDataStore {
    var venueInfo: FoursquareVenue? { get set }
}

class RestaurantsDetailsInteractor: RestaurantsDetailsBusinessLogic, RestaurantsDetailsDataStore {
    
    var presenter: RestaurantsDetailsPresentationLogic?
    
    var venueInfo: FoursquareVenue?
}
