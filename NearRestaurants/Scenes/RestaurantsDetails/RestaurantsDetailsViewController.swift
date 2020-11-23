//
//  RestaurantsDetailsViewController.swift
//  NearRestaurants
//
//  Created by Gabriel Figueiredo Conde on 11/21/20.
//

import UIKit

protocol RestaurantsDetailsDisplayLogic {
    func displayVenueDetails(viewModel: RestaurantsDetail.GetInfo.ViewModel)
}

class RestaurantsDetailsViewController: BaseViewController, RestaurantsDetailsDisplayLogic {

    var router: RestaurantsDetailsDataPassing?
    var interactor: RestaurantsDetailsBusinessLogic?
    
    fileprivate let cellIdentifier = String(describing: VenueDetailsTableViewCell.self)
    
    var venuesInfoList: [VenueDetailsCellModel] = []
    
    @IBOutlet private weak var venueInfoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func viewSetup() {
        venueInfoTableView.dataSource = self
        venueInfoTableView.register(UINib(nibName: String(describing: VenueDetailsTableViewCell.self), bundle: nil), forCellReuseIdentifier: cellIdentifier)
        venueInfoTableView.tableFooterView = UIView(frame: .zero)
        interactor?.fetchVenueDetails(request: RestaurantsDetail.GetInfo.Request())
    }
    
    func displayVenueDetails(viewModel: RestaurantsDetail.GetInfo.ViewModel) {
        venuesInfoList = viewModel.venueImageInfoList
        venueInfoTableView.reloadData()
    }
}

extension RestaurantsDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venuesInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? VenueDetailsTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        let model = venuesInfoList[indexPath.row]
        cell.config(model: model)
        
        return cell
    }
}
