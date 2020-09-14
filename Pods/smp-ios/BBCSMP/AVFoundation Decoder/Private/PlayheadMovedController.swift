//
//  PlayheadMovedController.swift
//  SMP
//
//  Created by Tim Condon on 14/03/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation
import AVFoundation
import CoreMedia

@objc(BBCSMPAVPlayheadMovedController)
public class PlayheadMovedController: NSObject {
    var pendingSeekTargetTime: CMTime?
    var pendingSeek: Bool
    private var player: AVPlayerProtocol
    private weak var playerItem: AVPlayerItem?
    private weak var decoderDelegate: BBCSMPDecoderDelegate?
    private var isPendingSeek: ((AVPlayheadMovedEvent) -> Bool)
    private var seekTolerance: TimeInterval
    private var timerFactory: BBCSMPTimerFactoryProtocol
    private var timer: BBCSMPTimerProtocol?
    private var seekCompleteTimeout: TimeInterval

    @objc public init(eventBus: BBCSMPEventBus, player: AVPlayerProtocol, seekTolerance: TimeInterval, timerFactory: BBCSMPTimerFactoryProtocol,
                      seekCompleteTimeout: TimeInterval) {
        self.player = player
        self.pendingSeek = false
        self.isPendingSeek = { _ in
            return false
        }
        self.seekTolerance = seekTolerance
        self.timerFactory = timerFactory
        self.seekCompleteTimeout = seekCompleteTimeout

        super.init()

        eventBus.addTarget(self, selector: #selector(playerItemDidChange), forEventType: AVPlayerItemChangedEvent.self)
        eventBus.addTarget(self, selector: #selector(playheadDidMove), forEventType: AVPlayheadMovedEvent.self)
        eventBus.addTarget(self, selector: #selector(decoderDelegateDidChange), forEventType: AVDecoderDelegateDidChangeEvent.self)
    }

    @objc public func playerItemDidChange(event: AVPlayerItemChangedEvent) {
        playerItem = event.playerItem
    }

    @objc public func playheadDidMove(event: AVPlayheadMovedEvent) {
        guard !isPendingSeek(event) else {
            return
        }

        cancelPendingSeek()

        notifyDelegateTimeChange(playheadPosition: event.playheadPosition)
        notifyDelegateDecoderPlayingOrPaused()
    }

    @objc public func decoderDelegateDidChange(event: AVDecoderDelegateDidChangeEvent) {
        decoderDelegate = event.decoderDelegate
        provideDecoderDelegateWithDefaultDecoderPositionBeforeAnyAdditionalUpdates()
    }

    func notifyDelegateTimeChange(playheadPosition: CMTime) {
        guard let currentTime = currentTimeWithIndicatedPlayheadPosition(playheadPosition) else {return}
        decoderDelegate?.decoderDidProgress(to: DecoderCurrentPosition(seconds: currentTime))
    }

    func currentTimeWithIndicatedPlayheadPosition(_ playheadPosition: CMTime) -> TimeInterval? {
        guard let playerItem = playerItem else {return nil}
        if !CMTIME_IS_INDEFINITE(playerItem.duration) {
            return CMTimeGetSeconds(playheadPosition)
        } else {
            return playerItem.currentDate()?.timeIntervalSince1970
        }
    }

    func notifyDelegateDecoderPlayingOrPaused() {
        if player.rate == 0 {
            decoderDelegate?.decoderPaused()
        } else {
            decoderDelegate?.decoderPlaying()
        }
    }

    func provideDecoderDelegateWithDefaultDecoderPositionBeforeAnyAdditionalUpdates() {
        let defaultDecoderPosition = DecoderCurrentPosition.zero()
        decoderDelegate?.decoderDidProgress(to: defaultDecoderPosition)
    }

    @objc public func setPendingSeekTargetTime(_ time: CMTime) {
        timer?.stop()
        timer = timerFactory.timer(withInterval: seekCompleteTimeout, target: self, selector: #selector(seekTimerExpired))
        isPendingSeek = { event in
            return CMTimeAbsoluteValue((event.playheadPosition - time)).seconds > self.seekTolerance
        }
    }

    @objc func seekTimerExpired() {
        decoderDelegate?.decoderEventOccurred?(DecoderSeekTimeOutEvent())
        self.cancelPendingSeek()
    }

    @objc public func cancelPendingSeek() {
        timer?.stop()
        isPendingSeek = { _ in
            return false
        }
    }
}

@objc(BBCSMPAVPlayerItemChangedEvent)
public class AVPlayerItemChangedEvent: NSObject {
    @objc public let playerItem: AVPlayerItem

    @objc public init(playerItem: AVPlayerItem) {
        self.playerItem = playerItem
    }
}

@objc(BBCSMPAVPlayheadMovedEvent)
public class AVPlayheadMovedEvent: NSObject {
    @objc public let playheadPosition: CMTime

    @objc public init(playheadPosition: CMTime) {
        self.playheadPosition = playheadPosition
    }
}

@objc(BBCSMPAVDecoderDelegateDidChangeEvent)
public class AVDecoderDelegateDidChangeEvent: NSObject {
    @objc public weak var decoderDelegate: BBCSMPDecoderDelegate?

    @objc public init(decoderDelegate: BBCSMPDecoderDelegate?) {
        self.decoderDelegate = decoderDelegate
    }
}

@objc(BBCSMPDecoderSeekTimeOutEvent)
public class DecoderSeekTimeOutEvent: NSObject, DecoderEvent {}
