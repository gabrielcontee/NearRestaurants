//
//  FoursquareClient.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import Foundation

final class FoursquareClient: APIClient {
    
    var appErrorDomain: String = "gabrielcontee.NearRestaurants.NetworkingError"
    
    let configuration: URLSessionConfiguration
    
    lazy var session: URLSession = {
        return URLSession(configuration: self.configuration)
    }()
    
    let clientID: String
    let clientSecret: String
    
    init(configuration: URLSessionConfiguration, clientID: String, clientSecret: String) {
        self.configuration = configuration
        self.clientID = clientID
        self.clientSecret = clientSecret
    }
    
    convenience init(clientID: String, clientSecret: String) {
        self.init(configuration: .default, clientID: clientID, clientSecret: clientSecret)
    }
    
    func fetchLocationsFor(_ location: FoursquareCoordinate, category: LocationCategory, completion: @escaping (APIResult<[FoursquareVenue]>) -> Void) {
        
        let searchEndpoint = FoursquareAPI.VenueEndpoint.search(clientID: self.clientID, clientSecret: self.clientSecret, coordinate: location, category: category)
        let endpoint = FoursquareAPI.venues(searchEndpoint)
        
        performRequestTo(endpoint, parse: { json -> [FoursquareVenue]? in
            
            guard let venues = json["response"]?["venues"] as? [[String: AnyObject]] else {
                return nil
            }
            
            return venues.compactMap { venueDict in
                return FoursquareVenue(JSON: venueDict)
            }
            
        }, completion: completion)
    }
}























