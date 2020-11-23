//
//  RestaurantsMapWorkerSpy.swift
//  NearRestaurantsTests
//
//  Created by Gabriel Figueiredo Conte on 11/22/20.
//

import Foundation
@testable import NearRestaurants

class RestaurantsMapWorkerSpy: RestaurantsMapWorkingLogic {
    
    var fetchCloseRestaurantsCalled = false
    
    func fetchCloseRestaurants(for coordinate: FoursquareCoordinate, category: LocationCategory, completion: @escaping (APIResult<[FoursquareVenue]>) -> Void) {
        fetchCloseRestaurantsCalled = true
        completion(.success(venuesMock))
    }
}

