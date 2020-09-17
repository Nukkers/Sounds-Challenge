//
//  ScheduleViewModel.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 15/09/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import UIKit

protocol DisplayablesUpdatedDelegate: class {
    func displayablesUpdated()
}

public class StationsViewModel {
    var displayableItem: DisplayableItem?

    weak var displayablesUpdatedDelegate: DisplayablesUpdatedDelegate?
    
    init() {
        fetchDisplayableItems()
    }
    
    
    func fetchDisplayableItems() {
        let session = URLSession.shared
        let url = URL(string: "https://iplayer-radio-mobile-appconfig.files.bbci.co.uk/appconfig/cap/ios/1.6.0/config.json")!
        var apiKey = ""
        var rootUrl =  ""
        
        var appStatus: AppStatus!
        
        let task = session.dataTask(with: url) { data, response, error in
            
            // check if we have any errors
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let data = data else { return }
            
            // Check the response is of type HTTPURLResponse &&
            // statusCode is between 200-299
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            // Check if the application type is JSON
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            let decoder = JSONDecoder()
            do {
                appStatus = try decoder.decode(AppStatus.self, from: data)
                apiKey = appStatus.rmsConfig.apiKey
                rootUrl = appStatus.rmsConfig.rootUrl
                
            } catch {
                print(error.localizedDescription)
            }
            
            let session = URLSession.shared
            let url = URL(string: "\(rootUrl)/v2/networks/playable?promoted=true")!
            
            var request = URLRequest(url: url)
            request.setValue(apiKey, forHTTPHeaderField: "X-API-Key")
            
            let task2 = session.dataTask(with: request) { data2, response, error in
                // check if we have any errors
                if error != nil || data2 == nil {
                    print("Client error!")
                    return
                }
                
                guard let data2 = data2 else { return }
                
                // Check the response is of type HTTPURLResponse &&
                // statusCode is between 200-299
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("Server error!")
                    return
                }
                
                // Check if the application type is JSON
                guard let mime = response.mimeType, mime == "application/json" else {
                    print("Wrong MIME type!")
                    return
                }
                
                let decoderData = JSONDecoder()
                
                do {
                    // Decode the data
                    self.displayableItem = try decoderData.decode(DisplayableItem.self, from: data2)
                    
                    self.displayableItem!.data = self.displayableItem!.data.map({
                        RMSPlayableItem(image_url: $0.image_url.replacingOccurrences(of: "{recipe}", with: "320x320"), titles: $0.titles, id: $0.id)
                    })
                    DispatchQueue.main.async {
                        self.displayablesUpdatedDelegate?.displayablesUpdated()
//                        return self.displayableItem
                    }
                    
                }catch{
                    print("There was an error \(error)")
                }
            }
            task2.resume()
        }
        task.resume()
     
    }
    

}

