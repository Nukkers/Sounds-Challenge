//
//  MainCoordinator.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 22/09/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator, AppConfigUpdatedDelegate {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = RequestAppConfigViewController.instantiate()
        let appConfigRepository = AppConfigRepository()
        let appConfigService = AppConfigService(appConfigRepository: appConfigRepository)
        let requestAppConfigVM = RequestAppConfigViewModel(appConfigService: appConfigService)
        vc.coordinator = self
        vc.requestAppConfigVM = requestAppConfigVM
        requestAppConfigVM.appConfigUpdatedDelegate = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func displayStationDetail(to item: RMSPlayableItem) {
        let stationsDetailVM = StationsDetailViewModel(data: item)
        let vc = StationsDetailViewController.instantiate()
        vc.coordinator = self
        vc.stationsDetailVM = stationsDetailVM
        navigationController.pushViewController(vc, animated: true)
    }
    
    func appConfigUpdated(apiKey: String, rootUrl: String) {
        let stationsVM = StationsViewModel(apiKey: apiKey, rootUrl: rootUrl)
        let vc = StationsViewController.instantiate()
        vc.coordinator = self
        vc.stationsVM = stationsVM
        navigationController.viewControllers = [vc]
    }
}
