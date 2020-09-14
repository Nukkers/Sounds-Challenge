//
//  DateProvider.swift
//  SMP
//
//  Created by Matt Mould on 14/02/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

@objc(BBCSMPDateProvider)
public protocol DateProvider {
    func currentDate() -> Date
}
