//
//  FoursquareVenue.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import Foundation

struct FoursquareVenue: Hashable {
    
    let id: String
    let name: String
    let location: FoursquareLocation
    let categoryName: String
    private(set) var checkins: Int? = nil
    private(set) var formattedPhone: String? = nil
    private(set) var url: String? = nil
    private(set) var hours: String? = nil
}

extension FoursquareVenue: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let id = JSON["id"] as? String,
              let name = JSON["name"] as? String,
              let categories = JSON["categories"] as? [[String: AnyObject]],
              let category = categories.first,
              let categoryName = category["shortName"] as? String,
              let locationDict = JSON["location"] as? [String: AnyObject],
              let establishmentLocation = FoursquareLocation(JSON: locationDict) else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.categoryName = categoryName
        self.location = establishmentLocation
        
        if let stats = JSON["stats"] as? [String: AnyObject], let checkinsCount = stats["checkinsCount"] as? Int {
            self.checkins = checkinsCount
        }
        
        if let contactInfo = JSON["contact"] as? [String: AnyObject], let phoneNumber = contactInfo["formattedPhone"] as? String {
            self.formattedPhone = phoneNumber
        }
        
        self.url = JSON["url"] as? String
        self.hours = JSON["hours"] as? String
    }
}
