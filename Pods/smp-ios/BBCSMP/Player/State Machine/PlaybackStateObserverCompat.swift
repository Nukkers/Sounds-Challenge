//
//  PlaybackStateObserverCompat.swift
//  SMP
//
//  Created by Matt Mould on 06/09/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

@objc(BBCSMPPlaybackStateObserverCompat)
public class PlaybackStateObserverCompat: NSObject, PlaybackStateObserver, BBCSMPObserver {

    weak var observer: PlaybackStateObserver?

    @objc
    public init(observer: PlaybackStateObserver) {
        self.observer = observer
    }

    @objc
    public func state(_ state: PlaybackState) {
        observer?.state(state)
    }

}
