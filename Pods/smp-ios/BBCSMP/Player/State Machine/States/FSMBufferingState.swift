//
//  FSMBufferingState.swift
//  SMP
//
//  Created by Matt Mould on 18/12/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

class FSMBufferingState: FSMState {
    weak var fsm: FSM?
    let publicState = SMPPublicState.buffering()

    init(_ fsm: FSM?) {
        self.fsm = fsm
    }

    func didBecomeActive() {
        fsm?.pendingSeek()
    }

    func formulateStateRestorationWhenRecovered(player: BBCSMP) {
        let timeToReturnToWhenReady = player.time
        self.fsm?.autoplay = true
        fsm?.actionWhenReady = {[unowned player] in
            guard let storedTime = timeToReturnToWhenReady else {return}
            player.scrub(to: storedTime.seconds)
        }
    }

    func pause() {
        fsm?.decoder?.pause()
        fsm?.transition(to: FSMPausedState(fsm))
    }

    func decoderPaused() {
        fsm?.transition(to: FSMPausedState(fsm))
    }

    func decoderReady() {
        fsm?.announceDurationChange()
        if fsm?.autoplay ?? false && fsm?.backgroundManager?.isAllowedToPlay ?? false {
            fsm?.decoder?.play()
        }
    }

    func seek(to time: TimeInterval, on player: BBCSMP) {
        fsm?.transition(to: FSMBufferingSeekingState(fsm))
        fsm?.decoder?.scrub(toAbsoluteTime: time)
    }

}
