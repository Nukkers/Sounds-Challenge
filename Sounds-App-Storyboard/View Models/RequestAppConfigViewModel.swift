//
//  RequestConfigViewModel.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 13/10/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import UIKit

protocol AppConfigUpdatedDelegate: class {
    func appConfigUpdated(apiKey: String, rootUrl: String)
}

protocol AppConfigViewDelegate: class {
    func appConfigFailed(message: String)
}

class RequestAppConfigViewModel {

    weak var appConfigViewDelegate: AppConfigViewDelegate?
    weak var appConfigUpdatedDelegate: AppConfigUpdatedDelegate?
    
    private let appConfigService: AppConfigServiceProtocol?
    
    init(appConfigService: AppConfigServiceProtocol) {
        self.appConfigService = appConfigService
    }
    
    func loadAppConfig() {
        appConfigService?.loadAppConfig { apiKey, rootUrl, result in
            
            if result {
                self.appConfigUpdatedDelegate?.appConfigUpdated(apiKey: apiKey, rootUrl: rootUrl)
            } else {
                self.appConfigViewDelegate?.appConfigFailed(message: "Failed to get app config. Try again later.")
            }
        }
    }
}
