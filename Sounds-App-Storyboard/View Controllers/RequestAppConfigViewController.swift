//
//  RequestAppConfigViewController.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 14/10/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import UIKit

class RequestAppConfigViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var loadingTextView: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    weak var coordinator: MainCoordinator?
    var requestAppConfigVM: RequestAppConfigViewModel? {
        didSet {
            requestAppConfigVM?.appConfigViewDelegate = self
        }
    }
    override func viewDidLoad() {
        tryAgainButton.isHidden = true
        requestAppConfigVM?.loadAppConfig()
    }
    
    @IBAction func tryAgainButtonTapped(_ sender: Any) {
        requestAppConfigVM?.loadAppConfig()
    }
}

extension RequestAppConfigViewController: AppConfigViewDelegate {
    func appConfigFailed(message: String) {
        // Update the UI with error message
        loadingTextView.text = message
        tryAgainButton.isHidden = false
    }
}
