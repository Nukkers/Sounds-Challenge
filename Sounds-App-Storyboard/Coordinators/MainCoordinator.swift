//
//  MainCoordinator.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 22/09/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = StationsViewController.instantiate()
        vc.coordinator = self
    
        navigationController.pushViewController(vc, animated: false)
    }
    
    func displayStationDetail(to item: RMSPlayableItem) {
        let stationsDetailVM = StationsDetailViewModel(data: item)
        let vc = StationsDetailViewController.instantiate()
        vc.coordinator = self
        vc.stationsDetailVM = stationsDetailVM
        navigationController.pushViewController(vc, animated: true)
    }
}
