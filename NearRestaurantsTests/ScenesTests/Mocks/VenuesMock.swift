//
//  VenuesMock.swift
//  NearRestaurantsTests
//
//  Created by Gabriel Figueiredo Conte on 11/22/20.
//

import Foundation
@testable import NearRestaurants

let venuesMock: [FoursquareVenue] = [
    FoursquareVenue(id: "1", name: "Bobs", location: locationMockOne, categoryName: "Barbecue"),
    FoursquareVenue(id: "2", name: "Jennys", location: locationMockTwo, categoryName: "Vegan")
]
