//
//  RestaurantsMapViewController.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import UIKit
import MapKit

protocol RestaurantsMapDisplayLogic {
    func displayRestaurants(viewModel: RestaurantsMap.Venues.ViewModel)
    func displayErrorPopup(viewModel: RestaurantsMap.Venues.ErrorViewModel)
    func displayVenueDetails(viewModel: RestaurantsMap.GetVenueDetail.ViewModel)
}

class RestaurantsMapViewController: BaseViewController, RestaurantsMapDisplayLogic {
    
    @IBOutlet private weak var mapView: MKMapView!
    
    var interactor: RestaurantsMapBusinessLogic?
    var router: (RestaurantsMapRoutingLogic & RestaurantsMapDataPassing)?
    var coordinate: FoursquareCoordinate?
    var locationManager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupMap() {
        self.title = "Restaurants Finder"
        guard let lastKnowLocation = locationManager.lastKnownLocation else {
            return
        }
        let latitude = lastKnowLocation.latitude
        let longitude = lastKnowLocation.longitude
        let venueRequest = RestaurantsMap.Venues.Request(latitude: latitude, longitude: longitude)
        interactor?.fetchRestaurants(request: venueRequest)
        setMapRegion(latitude: latitude, longitude: longitude)
    }
    
    func displayRestaurants(viewModel: RestaurantsMap.Venues.ViewModel) {
        addMapAnnotations(for: viewModel.restaurants)
    }
    
    func displayErrorPopup(viewModel: RestaurantsMap.Venues.ErrorViewModel) {
        self.presentAlert(title: "Oops, we had a problem", message: viewModel.errorDescription)
    }
    
    func displayVenueDetails(viewModel: RestaurantsMap.GetVenueDetail.ViewModel) {
        router?.routeToDetails()
    }
}

extension RestaurantsMapViewController: MKMapViewDelegate {
    
    fileprivate func extractedFunc() {
        removeMapAnnotations()
    }
    
    func addMapAnnotations(for venues: [FoursquareVenue]) {
        extractedFunc()
        
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
        let venueRequest = RestaurantsMap.Venues.Request(latitude: centerCoordinateViewed.latitude, longitude: centerCoordinateViewed.longitude)
        interactor?.fetchRestaurants(request: venueRequest)
    }
    
    func setMapRegion(latitude: Double, longitude: Double) {
        let zoomRange = 0.02
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
        let request = RestaurantsMap.GetVenueDetail.Request(venueName: annotationView.title)
        interactor?.handleVenueSelection(request: request)
    }
}
