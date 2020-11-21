//
//  LocationManager.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import CoreLocation

class LocationManager: NSObject {
    
    let locationManager = CLLocationManager()
    
    var locationUpdate: ((FoursquareCoordinate) -> Void)?
    
    override init() {
        super.init()
        setup()
    }
    
    private func setup() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestLocation()
        
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else { return }
        
        let coordinate = FoursquareCoordinate(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        if let locationUpdate = locationUpdate {
            locationUpdate(coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

