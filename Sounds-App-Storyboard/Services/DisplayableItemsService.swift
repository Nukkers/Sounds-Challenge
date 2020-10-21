//
//  DisplayablesService.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 21/10/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

protocol DisplayableItemsServiceProtocol: class {
    func loadDisplayableItems(completion: @escaping (DisplayableItem) -> Void)
}

import Foundation
class DisplayableItemsService: DisplayableItemsServiceProtocol {
   
    private let displayableItemsRepository: DisplayableItemsRepositoryProtocol
    
    init(displayableItemsRepository: DisplayableItemsRepositoryProtocol) {
        self.displayableItemsRepository = displayableItemsRepository
    }
    
    func loadDisplayableItems(completion: @escaping (DisplayableItem) -> Void) {
        self.displayableItemsRepository.loadDisplayableItems(completion: { displayableItem in
            completion(displayableItem)
        })
            
    }
    
}
