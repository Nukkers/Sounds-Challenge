//
//  FSMPausedState.swift
//  SMP
//
//  Created by Matt Mould on 18/12/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

class FSMPausedState: FSMState {
    weak var fsm: FSM?
    let publicState = SMPPublicState.paused()

    init(_ fsm: FSM?) {
        self.fsm = fsm
    }

    func play() {
        fsm?.transition(to: FSMPlayingState(fsm))
        self.fsm?.decoder?.play()
    }

    func pause () {}

    func decoderReady() {}

    func didBecomeActive() {
        self.fsm?.suspendMechanism.evaluateSuspendRule()
        fsm?.pendingSeek()
    }

    func didResignActive() {
        self.fsm?.suspendMechanism.cancelPendingSuspendTransition()
    }

    func seek(to time: TimeInterval, on player: BBCSMP) {
        fsm?.transition(to: FSMPausedSeekingState(fsm))
        fsm?.decoder?.scrub(toAbsoluteTime: time)
    }

    func formulateStateRestorationWhenRecovered(player: BBCSMP) {
        let timeToReturnToWhenReady = player.time
        fsm?.autoplay = false
        weak var weakReferenceToPlayer = player
        fsm?.actionWhenReady = {
            self.fsm?.pause()
            guard let storedTime = timeToReturnToWhenReady else {return}
            weakReferenceToPlayer?.scrub(to: storedTime.seconds)
        }
    }

    func suspend(player: BBCSMP) {
        self.fsm?.formulateStateRestorationWhenRecovered(player: player)
        self.fsm?.transition(to: FSMSuspendedState(fsm))
    }

    func decoderInterrupted() {
        fsm?.transition(to: FSMInterruptedState(fsm, resumeWhenReady: false))
    }

    func attemptFailover(from error: BBCSMPError) {
        fsm?.transition(to: FSMPausedRetryItemLoadingState(fsm, error) {[weak fsm] (retryItemState: FSMState) in
            fsm?.autoplay = false
            fsm?.transition(to: retryItemState)
        })
    }

}
