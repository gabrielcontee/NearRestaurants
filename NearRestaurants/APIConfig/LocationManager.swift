//
//  LocationManager.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import CoreLocation

class LocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    
    var lastKnownLocation: FoursquareCoordinate?
    
    override init() {
        super.init()
        setup()
    }
    
    private func setup() {
        locationManager.delegate = self
        requestLocationAuth()
    }
    
    func requestLocationAuth() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            self.locationManager.startUpdatingLocation()
        }else{
            requestLocationAuth()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let coordinate = FoursquareCoordinate(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        lastKnownLocation = coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

