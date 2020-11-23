//
//  RestaurantsMapWorker.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import Foundation

protocol RestaurantsMapWorkingLogic {
    func fetchCloseRestaurants(for coordinate: FoursquareCoordinate, category: LocationCategory, completion: @escaping (APIResult<[FoursquareVenue]>) -> Void)
}

class RestaurantsMapWorker: RestaurantsMapWorkingLogic {
    
    private let foursquareClient = FoursquareClient(clientID: Keys.foursquareClientId.getKey(), clientSecret: Keys.foursquareClientSecret.getKey())
    
    func fetchCloseRestaurants(for coordinate: FoursquareCoordinate, category: LocationCategory, completion: @escaping (APIResult<[FoursquareVenue]>) -> Void) {
        self.foursquareClient.fetchLocationsFor(coordinate, category: category){ result in
            switch result {
            case .success(let venues):
                completion(.success(venues))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
