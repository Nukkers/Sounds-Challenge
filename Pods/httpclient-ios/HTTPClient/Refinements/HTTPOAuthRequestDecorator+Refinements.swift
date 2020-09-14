//
//  HTTPOAuthRequestDecorator+Refinements.swift
//  BBCHTTPClient
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 15/11/2016.
//  Copyright © 2016 BBC. All rights reserved.
//

import Foundation

public extension OAuthRequestDecorator {
    
    @objc class var decorator: OAuthRequestDecorator {
        return __oAuthRequestDecorator
    }
    
}
