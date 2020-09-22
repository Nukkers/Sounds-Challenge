//
//  Coordinator.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 22/09/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import UIKit

// Protocol all VC have to follow
protocol Coordinator {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController { get set }
    
    func start()
}
