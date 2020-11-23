//
//  RestaurantsDetailsConfigurator.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/22/20.
//

import UIKit

class RestaurantsDetailsConfigurator: ConfiguratorProtocol {
    
    func config(_ viewController: UIViewController) {
        
        guard let vc = viewController as? RestaurantsDetailsViewController else {
            return
        }
        
        let interactor = RestaurantsDetailsInteractor()
        let presenter = RestaurantsDetailsPresenter()
        let router = RestaurantsDetailsRouter()
        
        vc.interactor = interactor
        vc.router = router
        interactor.presenter = presenter
        presenter.viewController = vc
        router.dataStore = interactor
    }
}
