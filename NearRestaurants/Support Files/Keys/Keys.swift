//
//  Keys.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import Foundation

enum Keys: String {

    case foursquareClientId
    case foursquareClientSecret
    
    func getKey() -> String {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject>,
              let key = dict[self.rawValue] as? String else {
            return ""
        }
        return key
    }
}


