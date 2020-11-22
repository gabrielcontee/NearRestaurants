//
//  RestaurantsDetailsViewController.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import UIKit

protocol RestaurantsDetailsDisplayLogic {
    
}

class RestaurantsDetailsViewController: BaseViewController, RestaurantsDetailsDisplayLogic {

    var router: RestaurantsDetailsDataPassing?
    var interactor: RestaurantsDetailsBusinessLogic?
    
    
}
