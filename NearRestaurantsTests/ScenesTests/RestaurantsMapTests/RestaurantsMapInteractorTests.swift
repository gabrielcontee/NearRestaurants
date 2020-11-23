//
//  RestaurantsMapInteractorTests.swift
//  NearRestaurantsTests
//
//  Created by Gabriel Figueiredo Conte on 11/22/20.
//

import XCTest
@testable import NearRestaurants

class RestaurantsMapInteractorTests: XCTestCase {
    
    var sut: RestaurantsMapInteractor!
    
    override func setUpWithError() throws {
        setup()
    }
    
    override func tearDownWithError() throws {
        try? super.tearDownWithError()
    }
    
    func setup() {
        sut = RestaurantsMapInteractor()
    }
    
    func testFetchVenuesCall() {
        // Given
        let presentationSpy = RestaurantsMapPresentationLogicSpy()
        let workerSpy = RestaurantsMapWorkerSpy()
        sut.presenter = presentationSpy
        sut.worker = workerSpy
        
        // When
        let latitude = 52.356274 // Amsterdam arounds latitude
        let longitude = 4.870404 // Amsterdam arounds latitude
        let request = RestaurantsMap.Venues.Request(latitude: latitude, longitude: longitude)
        sut.fetchRestaurants(request: request)
        
        // Then
        XCTAssert(workerSpy.fetchCloseRestaurantsCalled, "Should've called completed fetched restaurants")
        XCTAssert(presentationSpy.presentRestaurantsCalled, "Should've called present fetched restaurants")
    }
    
    func testFetchVenuesObjects() {
        // Given
        let workerSpy = RestaurantsMapWorkerSpy()
        sut.worker = workerSpy
        
        // When
        let latitude = 52.356274 // Amsterdam arounds latitude
        let longitude = 4.870404 // Amsterdam arounds latitude
        let request = RestaurantsMap.Venues.Request(latitude: latitude, longitude: longitude)
        sut.fetchRestaurants(request: request)
        
        // Then
        XCTAssertEqual(sut.foodVenues.count, 2)
        XCTAssertEqual(sut.foodVenues[0].name, "Bobs")
        XCTAssertEqual(sut.foodVenues[1].name, "Jennys")
    }
    
}
