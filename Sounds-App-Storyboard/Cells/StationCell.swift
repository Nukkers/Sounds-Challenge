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
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    func setStationCellVM(item: StationCellViewModel){
        imageView?.image = UIImage.emptyImage(with: CGSize(width: 200, height: 200))
        imageView?.load(url: item.image)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
    

}

extension UIImageView {
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

extension UIImage {
    static func emptyImage(with size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
