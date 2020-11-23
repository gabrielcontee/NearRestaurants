//
//  RestaurantsMapConfigurator.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import UIKit

class RestaurantsMapConfigurator: ConfiguratorProtocol {
    
    func config(_ viewController: UIViewController) {
        
        guard let vc = viewController as? RestaurantsMapViewController else {
            return
        }
        
        let interactor = RestaurantsMapInteractor()
        let presenter = RestaurantsMapPresenter()
        let router = RestaurantsMapRouter()
        let worker = RestaurantsMapWorker()
        
        vc.interactor = interactor
        vc.router = router
        interactor.presenter = presenter
        interactor.worker = worker
        presenter.viewController = vc
        router.viewController = vc
        router.dataStore = interactor
    }
}
