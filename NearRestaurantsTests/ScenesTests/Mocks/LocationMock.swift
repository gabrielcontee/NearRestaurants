//
//  LocationMock.swift
//  NearRestaurantsTests
//
//  Created by Gabriel Figueiredo Conte on 11/22/20.
//

import Foundation
@testable import NearRestaurants

// Mark: - Coordinates

let coordinateMockOne = FoursquareCoordinate(latitude: 52.356274,
                                          longitude: 4.870404)

let coordinateMockTwo = FoursquareCoordinate(latitude: 52.35629,
                                          longitude: 4.87041)

// Mark: - Locations

let locationMockOne = FoursquareLocation(coordinate: coordinateMockOne,
                                      distance: nil,
                                      countryCode: nil,
                                      country: nil,
                                      state: nil,
                                      city: nil,
                                      streetAddress: "Test street one",
                                      crossStreet: nil,
                                      postalCode: nil)

let locationMockTwo = FoursquareLocation(coordinate: coordinateMockTwo,
                                      distance: nil,
                                      countryCode: nil,
                                      country: nil,
                                      state: nil,
                                      city: nil,
                                      streetAddress: "Test street two",
                                      crossStreet: nil,
                                      postalCode: nil)
