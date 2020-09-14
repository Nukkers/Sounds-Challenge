//
//  File.swift
//  SMP
//
//  Created by Matt Mould on 25/04/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

@objc(BBCSMPPlaybackStateObserver) public protocol PlaybackStateObserver: NSObjectProtocol {
    func state(_ state: PlaybackState)
}

@objc(SMPPlaybackState) public protocol PlaybackState {}
@objc(SMPPlaybackStateUnprepared) public class PlaybackStateUnprepared: NSObject, PlaybackState {}
@objc(SMPPlaybackStateLoading) public class PlaybackStateLoading: NSObject, PlaybackState {}
@objc(SMPPlaybackStatePaused) public class PlaybackStatePaused: NSObject, PlaybackState {}
@objc(SMPPlaybackStatePlaying) public class PlaybackStatePlaying: NSObject, PlaybackState {}
@objc(SMPPlaybackStateEnded) public class PlaybackStateEnded: NSObject, PlaybackState {}
@objc(SMPPlaybackStateFailed) public class PlaybackStateFailed: NSObject, PlaybackState {}
