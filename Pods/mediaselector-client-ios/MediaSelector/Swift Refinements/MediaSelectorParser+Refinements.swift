//
//  MediaSelectorParser+Refinements.swift
//  BBCMediaSelectorClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 08/11/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

import Foundation

public extension MediaSelectorParser {
    
    @objc public class var numberFormatter: NumberFormatter {
        return __createNumberFormatter
    }
    
    @objc public class var dateFormatter: DateFormatter {
        return __createDateFormatter
    }
    
}
