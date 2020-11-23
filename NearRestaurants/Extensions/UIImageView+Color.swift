//
//  UIImageView+Color.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conte on 11/22/20.
//

import UIKit

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}
