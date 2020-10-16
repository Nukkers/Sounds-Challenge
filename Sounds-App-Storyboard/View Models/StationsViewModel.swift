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
    private var apiKey = ""
    private var rootUrl = ""
    
    init(apiKey: String, rootUrl: String) {
        self.apiKey = apiKey
        self.rootUrl = rootUrl
        fetchDisplayableItems()
    }
    
    // Need to pass in rootURL and apiKey
    
    func fetchDisplayableItems() {
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
                }
                
            }catch{
                print("There was an error \(error)")
            }
        }
        task2.resume()
    }
}
