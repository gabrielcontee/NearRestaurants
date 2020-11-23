//
//  RestaurantsMapPresentationLogicSpy.swift
//  NearRestaurantsTests
//
//  Created by Gabriel Figueiredo Conte on 11/22/20.
//

import UIKit
@testable import NearRestaurants

class RestaurantsMapPresentationLogicSpy: RestaurantsMapPresentationLogic {
    
    var presentRestaurantsCalled = false
    func presentRestaurants(response: RestaurantsMap.Venues.Response) {
        presentRestaurantsCalled = true
    }
    
    var presentErrorCalled = false
    func presentError(response: RestaurantsMap.Venues.Response) {
        presentErrorCalled = true
    }
    
    var presentDetailsCalled = false
    func presentDetails(response: RestaurantsMap.GetVenueDetail.Response) {
        presentDetailsCalled = true
    }
}
