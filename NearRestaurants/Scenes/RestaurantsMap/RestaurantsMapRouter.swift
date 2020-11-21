//
//  RestaurantsMapRouter.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import UIKit

protocol RestaurantsMapRoutingLogic {
    
}

class RestaurantsMapRouter: RestaurantsMapRoutingLogic {
    
    weak var viewController: (UIViewController & RestaurantsMapDisplayLogic)?
}
