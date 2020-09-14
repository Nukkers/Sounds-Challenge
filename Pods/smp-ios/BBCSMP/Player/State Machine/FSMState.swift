//
//  FSMState.swift
//  SMP
//
//  Created by Matt Mould on 18/12/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

protocol FSMState {

    func loadPlayerItem()
    func play()
    func pause()
    func stop()
    func prepareToPlay()
    func itemLoaded(item: BBCSMPItem)
    func error(_ error: BBCSMPError)
    func itemProviderDidFailToLoadItem(_ error: BBCSMPError)
    func loadPlayerItemMetadataFailed(_ error: BBCSMPError)
    func notifyErrorObserver(_ observer: BBCSMPErrorObserver)
    func formulateStateRestorationWhenRecovered(player: BBCSMP)
    func suspend(player: BBCSMP)
    func seek(to time: TimeInterval, on player: BBCSMP)

    func decoderPlaying()
    func decoderBuffering(_ isBuffering: Bool)
    func decoderReady()
    func decoderFailed()
    func decoderFinished()
    func decoderInterrupted()
    func decoderPaused()
    func decoderDidProgress(to position: DecoderCurrentPosition)

    var publicState: SMPPublicState { get }
    var fsm: FSM? { get }

    func addObserver(_ observer: BBCSMPObserver, player: BBCSMP, seekableRange: BBCSMPTimeRange)
    func didBecomeActive()
    func didResignActive()

    func attemptFailover(from error: BBCSMPError)
}

extension FSMState {

    func loadPlayerItem() {}

    func play() {}

    func pause() {}

    func stop() {
        fsm?.transition(to: FSMStoppingState(fsm))
    }

    func prepareToPlay() {
        fsm?.transition(to: FSMPreparingToPlayState(fsm))
    }

    func itemLoaded(item: BBCSMPItem) {}

    func error(_ error: BBCSMPError) {
        fsm?.transition(to: FSMErrorState(fsm, error))
    }

    func itemProviderDidFailToLoadItem(_ error: BBCSMPError) {}

    func loadPlayerItemMetadataFailed(_ error: BBCSMPError) {}

    func notifyErrorObserver(_ observer: BBCSMPErrorObserver) {}

    func formulateStateRestorationWhenRecovered(player: BBCSMP) {}

    func suspend(player: BBCSMP) {}

    func seek(to time: TimeInterval, on player: BBCSMP) {}

    // MARK: - decoder methods
    func decoderPlaying() {
        fsm?.transition(to: FSMPlayingState(fsm))
    }

    func decoderBuffering(_ isBuffering: Bool) {
        if isBuffering {
            fsm?.transition(to: FSMBufferingState(fsm))
        }
    }

    func decoderReady() {}

    func decoderFailed() {
        fsm?.decoder?.pause()
        fsm?.decoder?.teardown()
    }

    func decoderFinished() {
        fsm?.decoder?.pause()
        fsm?.transition(to: FSMEndedState(fsm))
    }

    func decoderInterrupted() {
        fsm?.transition(to: FSMInterruptedState(fsm, resumeWhenReady: true))
    }

    func decoderPaused() {}

    func decoderDidProgress(to position: DecoderCurrentPosition) {
        fsm?.methodsNotMigratedToFSM?.setTimeOnPlayerContext(position)
    }

    func attemptFailover(from error: BBCSMPError) {
        fsm?.transition(to: FSMRetryItemLoadingState(fsm, error) {[weak fsm] (retryItemState: FSMState) in
            fsm?.autoplay = false
            fsm?.transition(to: retryItemState)
        })
    }

    public func addObserver(_ observer: BBCSMPObserver, player: BBCSMP, seekableRange: BBCSMPTimeRange) {
        if let timeObserver = observer as? BBCSMPTimeObserver {
            timeObserver.durationChanged(player.duration)
            timeObserver.seekableRangeChanged(seekableRange)
            if let playerTime = player.time {
                timeObserver.timeChanged(playerTime)
            }
        }
    }
    func didBecomeActive() {}
    func didResignActive() {}
}
