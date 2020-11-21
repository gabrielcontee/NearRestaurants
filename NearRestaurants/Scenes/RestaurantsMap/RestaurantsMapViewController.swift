//
//  RestaurantsMapViewController.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import UIKit
import MapKit

protocol RestaurantsMapDisplayLogic {
    
}

class RestaurantsMapViewController: BaseViewController, RestaurantsMapDisplayLogic {
    
    var interactor: RestaurantsMapBusinessLogic?
    var router: RestaurantsMapRoutingLogic?
    
    @IBOutlet weak var mapView: MKMapView!
    
}
  
