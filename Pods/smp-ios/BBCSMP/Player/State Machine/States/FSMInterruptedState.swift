//
//  FSMStateInterrupted.swift
//  SMP
//
//  Created by Tim Condon on 24/12/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

class FSMInterruptedState: FSMState {

    weak var fsm: FSM?
    let resumeWhenReady: Bool
    let publicState = SMPPublicState.paused()

    init(_ fsm: FSM?, resumeWhenReady: Bool) {
        self.fsm = fsm
        self.resumeWhenReady = resumeWhenReady
    }

    func decoderReady() {
        if resumeWhenReady && fsm?.interruptionEndedBehaviour == .autoresume {
            self.fsm?.decoder?.play()
        }
    }

    func pause() {}

    func play() {
        self.fsm?.decoder?.play()
    }

    func seek(to time: TimeInterval, on player: BBCSMP) {
        fsm?.transition(to: FSMPausedSeekingState(fsm))
        fsm?.decoder?.scrub(toAbsoluteTime: time)
    }
}
