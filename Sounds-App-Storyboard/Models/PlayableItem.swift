//
//  PlayableItem.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 15/09/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import UIKit

class PlayableItem {
    var primaryTitle: String
    var secondaryTitle: String
    var image: UIImage
    var image_url: String
    
    
    init(primary: String, secondary: String, image: UIImage, image_url: String) {
        self.primaryTitle = primary
        self.secondaryTitle = secondary
        self.image = image
        self.image_url = image_url
    }
}
