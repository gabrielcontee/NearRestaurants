//
//  BaseViewController.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import UIKit

class BaseViewController: UIViewController {

    var configurator: ConfiguratorProtocol?

    init() {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
    }

    init(configurator: ConfiguratorProtocol) {
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        self.configurator = configurator
        self.configurator?.config(self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
