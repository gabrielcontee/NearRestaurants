//
//  RestaurantsMapInteractor.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import Foundation

protocol RestaurantsMapBusinessLogic {
    func fetchRestaurants(request: RestaurantsMap.Venues.Request)
    func handleVenueSelection(request: RestaurantsMap.GetVenueDetail.Request)
}

protocol RestaurantsMapDataStore {
    var chosenVenue: FoursquareVenue? { get set }
}

class RestaurantsMapInteractor: RestaurantsMapBusinessLogic, RestaurantsMapDataStore {
    
    var presenter: RestaurantsMapPresentationLogic?
    var worker: RestaurantsMapWorkingLogic?
    
    var foodVenues: [FoursquareVenue] = []
    var chosenVenue: FoursquareVenue?
    
    var lastCoordinateFetched: FoursquareCoordinate?
    
    func fetchRestaurants(request: RestaurantsMap.Venues.Request) {
        let coordinate = FoursquareCoordinate(latitude: request.latitude, longitude: request.longitude)
        if isFetchNeeded(for: coordinate) {
            self.worker?.fetchCloseRestaurants(for: coordinate, category: .food) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let venues):
                    self.foodVenues = venues
                    let response = RestaurantsMap.Venues.Response(restaurants: venues)
                    self.presenter?.presentRestaurants(response: response)
                case .failure(let error):
                    let response = RestaurantsMap.Venues.Response(restaurants: [], errorMessage: error)
                    self.presenter?.presentError(response: response)
                }
            }
        }
    }
    
    func handleVenueSelection(request: RestaurantsMap.GetVenueDetail.Request) {
        chosenVenue = nil
        guard let name = request.venueName,
              let venueInfo = foodVenues.first(where: { $0.name == name }) else {
            return
        }
        chosenVenue = venueInfo
        let response = RestaurantsMap.GetVenueDetail.Response(venueInfo: venueInfo)
        presenter?.presentDetails(response: response)
    }
    
    private func isFetchNeeded(for coordinate: FoursquareCoordinate) -> Bool {
        let threshold: Double = 0.01
        guard let lastLatitude = lastCoordinateFetched?.latitude, let lastLongitude = lastCoordinateFetched?.longitude else {
            lastCoordinateFetched = FoursquareCoordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)
            return true
        }
        if abs(abs(coordinate.latitude) - abs(lastLatitude)) > threshold || abs(abs(coordinate.longitude) - abs(lastLongitude)) > threshold {
            lastCoordinateFetched = FoursquareCoordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)
            return true
        }
        return false
    }
}
