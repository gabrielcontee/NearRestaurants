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
    func displayErrorPopup(with title: String)
    func displayVenueDetails(venue: FoursquareVenue)
}

class RestaurantsMapViewController: BaseViewController, RestaurantsMapDisplayLogic {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var interactor: RestaurantsMapBusinessLogic?
    var router: RestaurantsMapRoutingLogic?
    var coordinate: FoursquareCoordinate?
    var locationManager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupMap()
    }
    
    private func setupMap() {
        guard let lastKnowLocation = locationManager.lastKnownLocation else {
            return
        }
        let latitude = lastKnowLocation.latitude
        let longitude = lastKnowLocation.longitude
        interactor?.fetchRestaurants(latitude: latitude, longitude: longitude)
        setMapRegion(latitude: latitude, longitude: longitude)
    }
    
    func displayRestaurants(venues: [FoursquareVenue]) {
        addMapAnnotations(for: venues)
    }
    
    func displayErrorPopup(with title: String) {
        // TO DO: display error pop up
    }
    
    func displayVenueDetails(venue: FoursquareVenue) {
        router?.routeToDetails(venue)
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
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let centerCoordinateViewed = mapView.region.center
        interactor?.fetchRestaurants(latitude: centerCoordinateViewed.latitude, longitude: centerCoordinateViewed.longitude)
    }
    
    func setMapRegion(latitude: Double, longitude: Double) {
        let zoomRange = 0.025
        let coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: zoomRange, longitudeDelta: zoomRange)
        var region = MKCoordinateRegion(center: coordinates, span: span)
        region.center = coordinates
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotationView = view.annotation as? MKPointAnnotation else {
            return
        }
        interactor?.handleVenueSelection(title: annotationView.title)
    }
}
