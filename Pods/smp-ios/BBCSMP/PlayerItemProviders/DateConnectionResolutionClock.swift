//
//  DateConnectionResolutionClock.swift
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 20/03/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

@objc(BBCSMPDateConnectionResolutionClock)
@objcMembers
public class DateConnectionResolutionClock: NSObject, ConnectionResolutionClock {

    public func currentTime() -> TimeInterval {
        return Date().timeIntervalSince1970
    }

}
