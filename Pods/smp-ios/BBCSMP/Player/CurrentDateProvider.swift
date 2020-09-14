//
//  CurrentDateProvider.swift
//  SMP
//
//  Created by Jenna Brown on 13/02/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

@objc(BBCSMPCurrentDateProvider)
public class CurrentDateProvider: NSObject, DateProvider {
    public func currentDate() -> Date {
        return Date()
    }
}
