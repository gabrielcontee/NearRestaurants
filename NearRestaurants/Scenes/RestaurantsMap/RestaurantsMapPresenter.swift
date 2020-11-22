//
//  RestaurantsMapPresenter.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import Foundation

protocol RestaurantsMapPresentationLogic {
    func presentRestaurants(response: RestaurantsMap.Venues.Response)
    func presentError(response: RestaurantsMap.Venues.Response)
    func presentDetails(response: RestaurantsMap.GetVenueDetail.Response)
}

class RestaurantsMapPresenter: RestaurantsMapPresentationLogic {
    
    var viewController: RestaurantsMapDisplayLogic?
    
    func presentRestaurants(response: RestaurantsMap.Venues.Response) {
        let viewModel = RestaurantsMap.Venues.ViewModel(restaurants: response.restaurants)
        viewController?.displayRestaurants(viewModel: viewModel)
    }
    
    func presentError(response: RestaurantsMap.Venues.Response) {
        if let errorDescription = response.errorMessage, errorDescription.localizedDescription != "" {
            let viewModel = RestaurantsMap.Venues.ErrorViewModel(errorDescription:  errorDescription.localizedDescription)
            viewController?.displayErrorPopup(viewModel: viewModel)
        } else {
            let viewModel = RestaurantsMap.Venues.ErrorViewModel(errorDescription:  "Could not load the restaurants")
            viewController?.displayErrorPopup(viewModel: viewModel)
        }
    }
    
    func presentDetails(response: RestaurantsMap.GetVenueDetail.Response) {
        let viewModel = RestaurantsMap.GetVenueDetail.ViewModel(venueInfo: response.venueInfo)
        viewController?.displayVenueDetails(viewModel: viewModel)
    }
}
