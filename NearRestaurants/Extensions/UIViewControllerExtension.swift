//
//  UIViewControllerExtension.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conte on 11/22/20.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message ?? "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


