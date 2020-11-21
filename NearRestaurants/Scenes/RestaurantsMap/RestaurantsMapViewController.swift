//
//  RestaurantsMapViewController.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import UIKit
import MapKit

protocol RestaurantsMapDisplayLogic {
    func displayRestaurants(venues: [FoursquareVenue])
}

class RestaurantsMapViewController: BaseViewController, RestaurantsMapDisplayLogic {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var interactor: RestaurantsMapBusinessLogic?
    var router: RestaurantsMapRoutingLogic?
    var coordinate: FoursquareCoordinate?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setMapRegion()
    }
    
    func displayRestaurants(venues: [FoursquareVenue]) {
        addMapAnnotations(for: venues)
    }
}

extension RestaurantsMapViewController: MKMapViewDelegate {
    
    func addMapAnnotations(for venues: [FoursquareVenue]) {
        removeMapAnnotations()
        
        let annotations: [MKPointAnnotation] = venues.map { venue in
            let point = MKPointAnnotation()
            
            if let coordinate = venue.location.coordinate {
                point.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                point.title = venue.name
            }
            return point
        }
        mapView.addAnnotations(annotations)
    }
    
    func removeMapAnnotations() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
    
    func setMapRegion() {
        var region = MKCoordinateRegion()
        region.center = mapView.userLocation.coordinate
        region.span.latitudeDelta = 0.05
        region.span.longitudeDelta = 0.05
        mapView.setRegion(region, animated: true)
    }
}

extension RestaurantsMapViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let coordinates = coordinate {
            interactor?.fetchRestaurants(latitude: coordinates.latitude, longitude: coordinates.longitude)
        }
    }
}
