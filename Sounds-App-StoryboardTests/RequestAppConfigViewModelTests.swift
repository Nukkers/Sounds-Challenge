//
//  RequestAppConfigViewModelTests.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 19/10/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import XCTest
@testable import Sounds_App_Storyboard

class RequestAppConfigViewModelTests: XCTestCase {

    var stubAppConfigService: StubAppConfigService?
    var requestAppConfigViewModel: RequestAppConfigViewModel!
    var stubAppConfigUpdatedDelegate: StubAppConfigUpdatedDelegate!
    var stubAppConfigViewDelegate: StubAppConfigViewDelegate!

    override func setUp() {
        stubAppConfigService = StubAppConfigService()
        
        stubAppConfigUpdatedDelegate = StubAppConfigUpdatedDelegate()
        stubAppConfigViewDelegate = StubAppConfigViewDelegate()
        
        self.requestAppConfigViewModel = RequestAppConfigViewModel(appConfigService: stubAppConfigService!)
        
        requestAppConfigViewModel.appConfigUpdatedDelegate = stubAppConfigUpdatedDelegate
        requestAppConfigViewModel.appConfigViewDelegate = stubAppConfigViewDelegate
    }
    
    
    func testSuccessfullyGotAppConfigBackFromService() {
        let expectedApiKey = "apiKey"
        let expectedRootUrl = "rootUrl"
        stubAppConfigService?.stubbedLoadAppConfigCompletionResult = (expectedApiKey, expectedRootUrl, true)
        requestAppConfigViewModel.loadAppConfig()
        XCTAssertEqual(stubAppConfigUpdatedDelegate.invokedAppConfigUpdatedParameters?.apiKey, expectedApiKey)
        XCTAssertEqual(stubAppConfigUpdatedDelegate.invokedAppConfigUpdatedParameters?.rootUrl, expectedRootUrl)
        
    }
    
    func testCouldNotGetAppConfigBackFromService() {
        let expectedApiKey = ""
        let expectedRootUrl = ""
        stubAppConfigService?.stubbedLoadAppConfigCompletionResult = (expectedApiKey, expectedRootUrl, false)
        requestAppConfigViewModel.loadAppConfig()
        XCTAssertEqual(stubAppConfigViewDelegate.invokedAppConfigFailed, true)
    }
    
    

}

class StubAppConfigViewDelegate: AppConfigViewDelegate {

    var invokedAppConfigFailed = false
    var invokedAppConfigFailedCount = 0
    var invokedAppConfigFailedParameters: (message: String, Void)?
    var invokedAppConfigFailedParametersList = [(message: String, Void)]()

    func appConfigFailed(message: String) {
        invokedAppConfigFailed = true
        invokedAppConfigFailedCount += 1
        invokedAppConfigFailedParameters = (message, ())
        invokedAppConfigFailedParametersList.append((message, ()))
    }
}

class StubAppConfigUpdatedDelegate: AppConfigUpdatedDelegate {

    var invokedAppConfigUpdated = false
    var invokedAppConfigUpdatedCount = 0
    var invokedAppConfigUpdatedParameters: (apiKey: String, rootUrl: String)?
    var invokedAppConfigUpdatedParametersList = [(apiKey: String, rootUrl: String)]()

    func appConfigUpdated(apiKey: String, rootUrl: String) {
        invokedAppConfigUpdated = true
        invokedAppConfigUpdatedCount += 1
        invokedAppConfigUpdatedParameters = (apiKey, rootUrl)
        invokedAppConfigUpdatedParametersList.append((apiKey, rootUrl))
    }
}

class StubAppConfigService: AppConfigServiceProtocol {

    var invokedLoadAppConfig = false
    var invokedLoadAppConfigCount = 0
    var stubbedLoadAppConfigCompletionResult: (String, String, Bool)?

    func loadAppConfig(completion: @escaping (String, String, Bool) -> Void) {
        invokedLoadAppConfig = true
        invokedLoadAppConfigCount += 1
        if let result = stubbedLoadAppConfigCompletionResult {
            completion(result.0, result.1, result.2)
        }
    }
}
