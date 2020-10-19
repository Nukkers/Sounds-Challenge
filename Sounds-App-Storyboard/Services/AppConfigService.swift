//
//  AppConfigService.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 16/10/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import Foundation

protocol AppConfigServiceProtocol: class {
    func loadAppConfig(completion: @escaping (String, String, Bool) -> Void)
}


class AppConfigService: AppConfigServiceProtocol {
    private let appConfigRepository: AppConfigRepository
    
    init(appConfigRepository: AppConfigRepository) {
        self.appConfigRepository = appConfigRepository
    }

    func loadAppConfig(completion: @escaping (String, String, Bool) -> Void) {
        
        appConfigRepository.config(completion: { apiKey, rootUrl, result in
            completion(apiKey, rootUrl, result)
        })
    }
}
