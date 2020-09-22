//
//  Storyboarded.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 22/09/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

// Any class that uses the storyboarded protocol will set its storyboard id as the ID of the class instantiating it
extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        print("The ID inside storyboard is: \(id)")
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
