//
//  RestaurantsMapInteractor.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import Foundation

protocol RestaurantsMapBusinessLogic {
    func fetchRestaurants(latitude: Double, longitude: Double)
}

class RestaurantsMapInteractor: RestaurantsMapBusinessLogic {
    
    var presenter: RestaurantsMapPresentationLogic?
    var worker: RestaurantsMapWorkingLogic?
    
    func fetchRestaurants(latitude: Double, longitude: Double) {
        let coordinate = FoursquareCoordinate(latitude: latitude, longitude: longitude)
        self.worker?.fetchCloseRestaurants(for: coordinate, category: .food, completion: { (result) in
            switch result {
            case .success(let venues):
                self.presenter?.presentRestaurants(venues: venues)
            case .failure(let error):
                self.presenter?.presentError(description: error.localizedDescription)
            }
        })
    }
}
