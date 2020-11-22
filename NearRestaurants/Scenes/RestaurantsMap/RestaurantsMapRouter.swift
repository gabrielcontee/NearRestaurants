//
//  RestaurantsMapRouter.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import UIKit

protocol RestaurantsMapRoutingLogic {
    func routeToDetails()
}

protocol RestaurantsMapDataPassing {
    var dataStore: RestaurantsMapDataStore? { get }
}

class RestaurantsMapRouter: RestaurantsMapRoutingLogic, RestaurantsMapDataPassing {

    weak var viewController: (UIViewController & RestaurantsMapDisplayLogic)?
    var dataStore: RestaurantsMapDataStore?
    
    func routeToDetails() {
        let detailsViewController = RestaurantsDetailsViewController(configurator: RestaurantsDetailsConfigurator())
        guard let mapsDataStore = dataStore,
              let detailsRouter = detailsViewController.router,
              var detailsDS = detailsRouter.dataStore else {
            return
        }
        passDataToDetails(source: mapsDataStore, destination: &detailsDS)
        detailsViewController.title = mapsDataStore.chosenVenue?.name
        viewController?.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func passDataToDetails(source: RestaurantsMapDataStore, destination: inout RestaurantsDetailsDataStore) {
        guard let venue = source.chosenVenue else {
            return
        }
        destination.venueInfo = venue
    }
}
