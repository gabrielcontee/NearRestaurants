//
//  FoursquareAPI.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import Foundation

enum FoursquareAPI: BaseRequestEndpoint {
    
    case venues(VenueEndpoint)
    
    enum VenueEndpoint: BaseRequestEndpoint {
        case search(clientID: String, clientSecret: String, coordinate: FoursquareCoordinate, category: LocationCategory)
        
        var scheme: String {
            return "https://"
        }
        
        var host: String {
            return "api.foursquare.com"
        }
        
        var path: String {
            switch self {
            case .search: return "/v2/venues/search"
            }
        }
        
        fileprivate struct ParameterKeys {
            static let clientID = "client_id"
            static let clientSecret = "client_secret"
            static let version = "v"
            static let category = "categoryId"
            static let location = "ll"
            static let query = "query"
            static let limit = "limit"
            static let searchRadius = "radius"
        }
        
        fileprivate struct DefaultValues {
            static let version = "20160301"
            static let limit = "50"
            static let searchRadius = "3000"
        }
        
        var parameters: [String : AnyObject] {
            switch self {
            case .search(let clientID, let clientSecret, let coordinate, let category):
                var parameters: [String: AnyObject] = [
                    ParameterKeys.clientID: clientID as AnyObject,
                    ParameterKeys.clientSecret: clientSecret as AnyObject,
                    ParameterKeys.version: DefaultValues.version as AnyObject,
                    ParameterKeys.location: coordinate.description as AnyObject,
                    ParameterKeys.category: category.rawValue as AnyObject
                ]
                
                parameters[ParameterKeys.searchRadius] = DefaultValues.searchRadius as AnyObject?
                parameters[ParameterKeys.limit] = DefaultValues.limit as AnyObject?
                
                return parameters
            }
        }
    }
    
    var scheme: String {
        switch self {
        case .venues(let endpoint):
            return endpoint.scheme
        }
    }
    
    var host: String {
        switch self {
        case .venues(let endpoint):
            return endpoint.host
        }
    }
    
    var path: String {
        switch self {
        case .venues(let endpoint):
            return endpoint.path
        }
    }
    
    var parameters: [String : AnyObject] {
        switch self {
        case .venues(let endpoint):
            return endpoint.parameters
        }
    }
}
