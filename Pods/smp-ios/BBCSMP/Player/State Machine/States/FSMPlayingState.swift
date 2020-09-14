//
//  FSMPlayingState.swift
//  SMP
//
//  Created by Matt Mould on 18/12/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

class FSMPlayingState: NSObject, FSMState {
    weak var fsm: FSM?
    let publicState = SMPPublicState.playing()

    init(_ fsm: FSM?) {
        self.fsm = fsm
    }

    func play() {}

    func decoderPlaying() {}

    func pause() {
        fsm?.decoder?.pause()
        fsm?.transition(to: FSMPausedState(fsm))
    }

    func decoderPaused() {
        fsm?.transition(to: FSMPausedState(fsm))
    }

    func formulateStateRestorationWhenRecovered(player: BBCSMP) {
        let timeToReturnToWhenReady = player.time
        fsm?.actionWhenReady = { [unowned player] in
            guard let storedTime = timeToReturnToWhenReady else {return}
            player.scrub(to: storedTime.seconds)
        }
    }

    func didBecomeActive() {
        fsm?.announceDurationChange()
        fsm?.pendingSeek()
    }

    func decoderBuffering(_ isBuffering: Bool) {
        if isBuffering {
            fsm?.autoplay = true
            fsm?.transition(to: FSMBufferingState(fsm))
        }
    }

    func loadPlayerItem() {
        fsm?.transition(to: FSMItemLoadingState(self.fsm))
    }

    func seek(to time: TimeInterval, on player: BBCSMP) {
        fsm?.transition(to: FSMPlayingSeekingState(fsm))
        fsm?.decoder?.scrub(toAbsoluteTime: time)
    }

}
