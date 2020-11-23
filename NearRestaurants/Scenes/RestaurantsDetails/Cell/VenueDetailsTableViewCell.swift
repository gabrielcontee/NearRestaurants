//
//  VenueDetailsTableViewCell.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conte on 11/22/20.
//

import UIKit

class VenueDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var cellImageView: UIImageView!
    @IBOutlet private weak var cellTitleLabel: UILabel!

    func config(model: VenueDetailsCellModel) {
        cellTitleLabel.text = model.info
        cellImageView.image = UIImage(named: model.imageName) ?? UIImage()
    }
}
