//
//  TimeBasedConnectionResolver.swift
//  SMP
//
//  Created by Raj Khokhar on 16/03/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

@objc(BBCSMPDelayedRunner)
public protocol DelayedRunner {

    func scheduleAfter(_ delay: TimeInterval, block: @escaping () -> Void)

}

@objc(BBCSMPTimeDelayConfiguration)
public protocol TimeDelayConfiguration {

    func delayForAttempt(_ attemptCount: Int) -> TimeInterval

}

@objc(BBCSMPConnectionResolutionClock)
public protocol ConnectionResolutionClock {

    func currentTime() -> TimeInterval

}

@objc(BBCSMPTimeBasedConnectionResolver)
@objcMembers
public class TimeBasedConnectionResolver: NSObject, BBCSMPMediaSelectorConnectionResolver {

    private let delayedRunner: DelayedRunner
    private let timeConfiguration: TimeDelayConfiguration
    private let clock: ConnectionResolutionClock
    private var itemAttemptMap: [URL: Attempt] = [:]

    private struct Attempt {
        var numberOfAttempts: Int
        var lastAttemptedAt: TimeInterval
    }

    public convenience override init() {
        self.init(delayedRunner: DispatchingDelayedRunner(),
                  timeConfiguration: CappedExponentialTimeConfig(),
                  clock: DateConnectionResolutionClock())
    }

    public init(delayedRunner: DelayedRunner, timeConfiguration: TimeDelayConfiguration, clock: ConnectionResolutionClock) {
        self.delayedRunner = delayedRunner
        self.timeConfiguration = timeConfiguration
        self.clock = clock
    }

    public func resolvePlayerItem(_ playerItem: BBCSMPItem, usingPlayerItemCallback callback: @escaping (BBCSMPItem) -> Void) {
        let url = playerItem.resolvedContent.content
        var attempt = numberOfAttempts(for: url)

        var delay = timeConfiguration.delayForAttempt(attempt.numberOfAttempts)
        let delayedCallback = { callback(playerItem) }

        if attempt.numberOfAttempts > 0 {
            let scheduledTime = attempt.lastAttemptedAt + timeConfiguration.delayForAttempt(attempt.numberOfAttempts)
            delay = max(0, scheduledTime - clock.currentTime())
        }

        delayedRunner.scheduleAfter(delay, block: delayedCallback)

        attempt.numberOfAttempts += 1
        attempt.lastAttemptedAt = clock.currentTime()
        itemAttemptMap[url] = attempt
    }

    private func numberOfAttempts(for url: URL) -> Attempt {
        return itemAttemptMap[url] ?? Attempt(numberOfAttempts: 0, lastAttemptedAt: clock.currentTime())
    }

}
