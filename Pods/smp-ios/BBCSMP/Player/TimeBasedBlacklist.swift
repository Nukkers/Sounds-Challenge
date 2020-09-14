//
//  TimerBasedBlacklist.swift
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 29/01/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

@objc(BBCSMPBlacklistClock)
public protocol BlacklistClock {

    var time: TimeInterval { get }

}

@objc(BBCSMPTimeBasedBlacklist)
@objcMembers
public class TimeBasedBlacklist: NSObject, BBCSMPMediaURLBlacklist {

    private struct Entry {
        var url: URL
        var timeAvailable: TimeInterval

        func stillBlacklisted(currentTime: TimeInterval) -> Bool {
            return timeAvailable > currentTime
        }
    }

    private class SystemBlacklistClock: BlacklistClock {

        var time: TimeInterval {
            return Date().timeIntervalSince1970
        }

    }

    private let blacklistInterval: TimeInterval
    private let blacklistClock: BlacklistClock
    private var entries = [Entry]()

    public override convenience init() {
        self.init(blacklistInterval: 120, blacklistClock: SystemBlacklistClock())
    }

    public convenience init(blacklistInterval: TimeInterval) {
        self.init(blacklistInterval: blacklistInterval, blacklistClock: SystemBlacklistClock())
    }

    public init(blacklistInterval: TimeInterval,
                blacklistClock: BlacklistClock) {
        self.blacklistInterval = blacklistInterval
        self.blacklistClock = blacklistClock
    }

    public func blacklistMediaURL(_ mediaURL: URL) {
        let entry = Entry(url: mediaURL, timeAvailable: blacklistClock.time + blacklistInterval)
        entries.append(entry)
    }

    public func containsMediaURL(_ mediaURL: URL) -> Bool {
        updateEntries()
        return entries.contains(where: { $0.url == mediaURL })
    }

    public func removeAllMediaURLs() {
        entries.removeAll()
    }

    private func updateEntries() {
        let time = blacklistClock.time
        entries = entries.filter({ $0.stillBlacklisted(currentTime: time) })
    }

}
