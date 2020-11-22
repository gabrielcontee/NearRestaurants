//
//  RestaurantsMapRouter.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import UIKit

protocol RestaurantsMapRoutingLogic {
    func routeToDetails(_ venue: FoursquareVenue)
}

class RestaurantsMapRouter: RestaurantsMapRoutingLogic {

    weak var viewController: (UIViewController & RestaurantsMapDisplayLogic)?
    
    func routeToDetails(_ venue: FoursquareVenue) {
        print(venue)
    }
}
