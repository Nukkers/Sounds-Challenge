//
//  CappedExponentialTimeConfig.swift
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 19/03/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

@objc(BBCSMPCappedExponentialTimeConfig)
@objcMembers
public class CappedExponentialTimeConfig: NSObject, TimeDelayConfiguration {

    private let cap: TimeInterval = 60

    public func delayForAttempt(_ attemptCount: Int) -> TimeInterval {
        var delay: TimeInterval = 0
        if attemptCount > 0 {
            delay = min(pow(2, Double(attemptCount - 1)) * 0.1, cap)
        }

        return delay
    }

}
