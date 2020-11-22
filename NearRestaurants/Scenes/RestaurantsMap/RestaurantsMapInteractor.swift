//
//  RestaurantsMapInteractor.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import Foundation

protocol RestaurantsMapBusinessLogic {
    func fetchRestaurants(latitude: Double, longitude: Double)
    func handleVenueSelection(title: String?)
}

class RestaurantsMapInteractor: RestaurantsMapBusinessLogic {
    
    var presenter: RestaurantsMapPresentationLogic?
    var worker: RestaurantsMapWorkingLogic?
    
    private var foodVenues: [FoursquareVenue] = []
    
    func fetchRestaurants(latitude: Double, longitude: Double) {
        let coordinate = FoursquareCoordinate(latitude: latitude, longitude: longitude)
        self.worker?.fetchCloseRestaurants(for: coordinate, category: .food) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let venues):
                self.foodVenues = venues
                self.presenter?.presentRestaurants(venues: venues)
            case .failure(let error):
                self.presenter?.presentError(description: error.localizedDescription)
            }
        }
    }
    
    func handleVenueSelection(title: String?) {
        guard let name = title,
              let venueInfo = foodVenues.first(where: { $0.name == name }) else {
            return
        }
        presenter?.presentDetails(of: venueInfo)
    }
}
