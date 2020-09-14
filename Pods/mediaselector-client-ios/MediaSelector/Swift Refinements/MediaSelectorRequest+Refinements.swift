//
//  MediaSelectorRequest+Refinements.swift
//  BBCMediaSelectorClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 08/11/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

import Foundation

public extension MediaSelectorRequest {
    
    @objc public func verify() throws {
        try __isValid()
    }
    
}
