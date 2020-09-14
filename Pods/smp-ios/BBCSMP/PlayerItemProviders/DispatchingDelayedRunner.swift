//
//  DispatchingDelayedRunner.swift
//  SMP
//
//  Created by Raj Khokhar on 16/03/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

public class DispatchingDelayedRunner: NSObject, DelayedRunner {

    public func scheduleAfter(_ delay: TimeInterval, block: @escaping () -> Void) {
        let delayInNanoSeconds: UInt64 = UInt64(delay * Double(NSEC_PER_SEC))
        let time = DispatchTime(uptimeNanoseconds: DispatchTime.now().uptimeNanoseconds + delayInNanoSeconds)
        DispatchQueue.main.asyncAfter(deadline: time, execute: block)
    }

}
