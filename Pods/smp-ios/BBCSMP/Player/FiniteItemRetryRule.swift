//
//  FiniteItemRetryRule.swift
//  SMP
//
//  Created by Thomas Sherwood on 31/10/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

import Foundation

@objc(BBCSMPFiniteItemRetryRule)
public class FiniteItemRetryRule: NSObject, BBCSMPItemRetryRule, BBCSMPItemObserver {

    private let retryLimit: Int
    private var evaluations = 0

    @objc public init(retryLimit: Int) {
        self.retryLimit = retryLimit
    }

    public func attach(to playerObservable: BBCSMPPlayerObservable) {
        playerObservable.add(observer: self)
    }

    public func evaluateRule() -> Bool {
        let satisfied = evaluations < retryLimit
        evaluations += 1

        return satisfied
    }

    public func itemUpdated(_ playerItem: BBCSMPItem) {
        evaluations = 0
    }

}
