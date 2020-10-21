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
    
    private let displayableItemsService: DisplayableItemsServiceProtocol?
    
    weak var displayablesUpdatedDelegate: DisplayablesUpdatedDelegate?
    var displayableItem: DisplayableItem?
    
    init(displayableItemsService: DisplayableItemsServiceProtocol) {
        self.displayableItemsService = displayableItemsService
        fetchDisplayableItems()
    }
    
    
    func fetchDisplayableItems() {
        displayableItemsService?.loadDisplayableItems(completion: { displayableItem in
            if !displayableItem.data.isEmpty {
                self.displayableItem = displayableItem
                DispatchQueue.main.async {
                    self.displayablesUpdatedDelegate?.displayablesUpdated()
                }
            } else {
                print("Unable to load displayable items. Try again later.")
                return
            }
        })
    }
}
