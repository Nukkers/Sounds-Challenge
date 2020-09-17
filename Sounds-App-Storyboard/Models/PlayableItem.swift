//
//  PlayableItem.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 15/09/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import Foundation

// This model is not being used anywhere!
class PlayableItem {
    var primaryTitle: String
    var secondaryTitle: String
    var image_url: String
    
    
    init(primary: String, secondary: String, image_url: String) {
        self.primaryTitle = primary
        self.secondaryTitle = secondary
        self.image_url = image_url
    }
    
    init(rmsPlayableItem: RMSPlayableItem) {
        self.primaryTitle = rmsPlayableItem.titles.primary
        self.secondaryTitle = rmsPlayableItem.titles.secondary
        self.image_url = rmsPlayableItem.image_url
    }
}
