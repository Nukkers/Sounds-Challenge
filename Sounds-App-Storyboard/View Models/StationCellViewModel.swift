//
//  PlayableItemCellViewModel.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 17/09/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import UIKit

class StationCellViewModel {
    let title: String
    let subtitle: String
    var image: UIImage?
    
    
    init(playableItem: PlayableItem) {
        title = playableItem.primaryTitle
        subtitle  = playableItem.secondaryTitle
        
        load(url: playableItem.image_url)
    }
    
    
    func load(url: String) {
        
        let url = URL(string: url)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            let newImage = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.image = newImage!
            }
        }
        task.resume()
    }
}
