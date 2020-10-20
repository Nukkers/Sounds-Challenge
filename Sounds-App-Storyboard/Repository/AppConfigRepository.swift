//
//  AppConfigRepository.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 16/10/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import Foundation

protocol AppConfigRepositoryProtocol: class {
    func config(completion: @escaping (String, String, Bool) -> Void)
}

class AppConfigRepository: AppConfigRepositoryProtocol {
    
    private let session = URLSession.shared
    private let url = URL(string: "https://iplayer-radio-mobile-appconfig.files.bbci.co.uk/appconfig/cap/ios/1.6.0/config.json")!
    
    private var apiKey = ""
    private var rootUrl =  ""
    private var appStatus: AppStatus?
    
    func config(completion: @escaping (String, String, Bool) -> Void) {
        
        let task = session.dataTask(with: url) { data, response, error in
            
            // check if we have any errors
            if error != nil || data == nil {
                print("Client error!")
                DispatchQueue.main.async {
                    completion("", "", false)
                }
                return
            }
            
            guard let data = data else { return }
            
            // Check the response is of type HTTPURLResponse &&
            // statusCode is between 200-299
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                DispatchQueue.main.async {
                    completion("", "", false)
                }
                return
            }
            
            // Check if the application type is JSON
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                DispatchQueue.main.async {
                    completion("", "", false)
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
                    completion(self.apiKey, self.rootUrl, true)
                }

            } catch {
                completion("", "", false)
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
