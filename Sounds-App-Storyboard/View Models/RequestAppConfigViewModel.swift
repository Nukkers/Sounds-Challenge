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
    
    private let session = URLSession.shared
    private let url = URL(string: "https://iplayer-radio-mobile-appconfig.files.bbci.co.uk/appconfig/cap/ios/1.6.0/config.json")!
    private var apiKey = ""
    private var rootUrl =  ""
    private var appStatus: AppStatus?
    
    weak var appConfigViewDelegate: AppConfigViewDelegate?
    weak var appConfigUpdatedDelegate: AppConfigUpdatedDelegate?
    
    func getAppConfig() {
        let task = session.dataTask(with: url) { data, response, error in
            
            // check if we have any errors
            if error != nil || data == nil {
                print("Client error!")
                DispatchQueue.main.async {
                    self.appConfigViewDelegate?.appConfigFailed(message: "Client Error \(error)")
                }
                return
            }
            
            guard let data = data else { return }
            
            // Check the response is of type HTTPURLResponse &&
            // statusCode is between 200-299
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                DispatchQueue.main.async {
                    self.appConfigViewDelegate?.appConfigFailed(message: "Server error.")
                }
                return
            }
            
            // Check if the application type is JSON
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                DispatchQueue.main.async {
                    self.appConfigViewDelegate?.appConfigFailed(message: "Wrong MIME type error.")
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                self.appStatus = try decoder.decode(AppStatus.self, from: data)
                self.apiKey = self.appStatus?.rmsConfig.apiKey ?? "ERROR"
                self.rootUrl = self.appStatus?.rmsConfig.rootUrl ?? "ERROR"
                // Successfull result received
                DispatchQueue.main.async {
                    self.appConfigUpdatedDelegate?.appConfigUpdated(apiKey: self.apiKey, rootUrl: self.rootUrl)
                }
            } catch {
                DispatchQueue.main.async {
                    self.appConfigViewDelegate?.appConfigFailed(message: "Unable to decode JSON response. Error description: \(error.localizedDescription)")
                }
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
