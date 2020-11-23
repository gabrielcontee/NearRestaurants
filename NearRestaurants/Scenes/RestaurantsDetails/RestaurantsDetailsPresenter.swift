//
//  RestaurantsDetailsPresenter.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/22/20.
//

import Foundation

protocol RestaurantsDetailsPresentationLogic {
    func presentVenueDetails(response: RestaurantsDetail.GetInfo.Response)
}

class RestaurantsDetailsPresenter: RestaurantsDetailsPresentationLogic {
    
    var viewController: RestaurantsDetailsDisplayLogic?
    
    func presentVenueDetails(response: RestaurantsDetail.GetInfo.Response) {
        let venue = response.venue
        let viewModel = RestaurantsDetail.GetInfo.ViewModel(venueImageInfoList: configureVenueDetailsList(venue: venue))
        viewController?.displayVenueDetails(viewModel: viewModel)
    }
    
    private func configureVenueDetailsList(venue: FoursquareVenue) -> [VenueDetailsCellModel] {
        var detailsInfoList: [VenueDetailsCellModel] = []
        
        let category = VenueDetailsCellModel(imageName: "category", info: "Category: \(venue.categoryName)")
        detailsInfoList.append(category)
        
        var address: String = ""
        let location = venue.location
        if let street = location.streetAddress {
            address.append("\(street) ")
        }
        if let city = location.city {
            address.append("\(city) ")
        }
        if let state = location.state {
            address.append("\(state) ")
        }
        if let country = location.country {
            address.append("\(country) ")
        }
        if address != "" {
            address.insert(contentsOf: "Address: ", at: address.startIndex)
            let restaurantLocation = VenueDetailsCellModel(imageName: "address", info: "\(address)")
            detailsInfoList.append(restaurantLocation)
        }
        
        if let checkins = venue.checkins {
            let checkins = VenueDetailsCellModel(imageName: "checkin", info: "Checkins: \(checkins)")
            detailsInfoList.append(checkins)
        }
        
        if let phone = venue.formattedPhone {
            let formattedPhone = VenueDetailsCellModel(imageName: "phone", info: "Phone: \(phone)")
            detailsInfoList.append(formattedPhone)
        }
        
        if let url = venue.url {
            let url = VenueDetailsCellModel(imageName: "url", info: "Website: \(url)")
            detailsInfoList.append(url)
        }
        
        if let workingHours = venue.hours {
            let workingHours = VenueDetailsCellModel(imageName: "working-hours", info: "Open at: \(workingHours)")
            detailsInfoList.append(workingHours)
        }
        
        return detailsInfoList
    }
}
