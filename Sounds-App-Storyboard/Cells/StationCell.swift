//
//  TableViewCellViewModel.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 17/09/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import UIKit


// MARK: - Custom table view cell classes

class StationCell: UITableViewCell{
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ImageView: UIImageView!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    func setStationCellVM(item: StationCellViewModel){
        ImageView.image = item.image
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
    
    
}
