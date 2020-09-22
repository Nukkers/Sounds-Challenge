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
    let image: String
    
    
    init(playableItem: PlayableItem) {
        title = playableItem.primaryTitle
        subtitle  = playableItem.secondaryTitle
        image = playableItem.image_url
    }
}
