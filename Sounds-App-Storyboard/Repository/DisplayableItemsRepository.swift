//
//  DisplayablesRepository.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 21/10/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import Foundation

protocol DisplayableItemsRepositoryProtocol: class {
    func loadDisplayableItems(completion: @escaping (DisplayableItem) -> Void)
}


class DisplayableItemsRepository: DisplayableItemsRepositoryProtocol {
    
    private var apiKey: String
    private var rootUrl: String
    var displayableItem: DisplayableItem?
    
    init(apiKey: String, rootUrl: String) {
        self.apiKey = apiKey
        self.rootUrl = rootUrl
    }
    
    func loadDisplayableItems(completion: @escaping (DisplayableItem) -> Void) {
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
                
                guard let displayableItem = self.displayableItem else {
                    print("Unable to unwrap self.displayableItem")
                    return
                }
                completion(displayableItem)
                
            }catch{
                print("There was an error \(error)")
            }
        }
        task2.resume()
    }
    
    
}
