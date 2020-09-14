//
//  PermanentMediaURLBlacklist.swift
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 25/01/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

@objc(BBCSMPPermanentMediaURLBlacklist)
@objcMembers
public class PermanentMediaURLBlacklist: NSObject, BBCSMPMediaURLBlacklist {

    private var blacklist = Set<URL>()

    public func blacklistMediaURL(_ mediaURL: URL) {
        blacklist.insert(mediaURL)
    }

    public func containsMediaURL(_ mediaURL: URL) -> Bool {
        return blacklist.contains(mediaURL)
    }

    public func removeAllMediaURLs() {
        blacklist.removeAll()
    }

}
