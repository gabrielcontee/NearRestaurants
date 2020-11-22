//
//  RestaurantsDetailsRouter.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conte on 11/22/20.
//

import Foundation

protocol RestaurantsDetailsDataPassing {
    var dataStore: RestaurantsDetailsDataStore? { get }
}

class RestaurantsDetailsRouter: RestaurantsDetailsDataPassing {

    var dataStore: RestaurantsDetailsDataStore?
}
