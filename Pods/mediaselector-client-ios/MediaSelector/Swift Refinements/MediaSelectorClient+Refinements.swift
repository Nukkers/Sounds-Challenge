//
//  MediaSelectorClient+Refinements.swift
//  BBCMediaSelectorClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 07/11/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

import Foundation

public extension MediaSelectorClient {
    
    @objc public class var shared: MediaSelectorClient {
        return __shared
    }
    
}
