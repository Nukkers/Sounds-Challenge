//
//  ResponseProcessor+Refinements.swift
//  BBCHTTPClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 15/11/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

import Foundation

public extension ResponseProcessor where Self: NSObject {
    
    static var processor: Self {
        return Self()
    }
    
}
