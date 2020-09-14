//
//  FSMRetryPausedPreparingToPlayState.swift
//  SMP
//
//  Created by Shahnaz Hameed on 09/07/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

class FSMPausedRetryPreparingToPlayState: FSMState {
    let publicState = SMPPublicState.paused()
    weak var fsm: FSM?
    let actionOnPause: (_ state: FSMState) -> Void

    init(_ fsm: FSM?, actionOnPause: @escaping (_ states: FSMState) -> Void) {
        self.fsm = fsm
        self.actionOnPause = actionOnPause
    }

    func decoderReady() {
        fsm?.announceDurationChange()
        fsm?.transition(to: FSMPlayerReadyState(fsm))
        if fsm?.autoplay ?? false && fsm?.backgroundManager?.isAllowedToPlay ?? false {
            fsm?.decoder?.play()
        }
    }

    func decoderBuffering(_ isBuffering: Bool) {}

    func play() {
        self.fsm?.autoplay = true
        fsm?.transition(to: FSMRetryPreparingToPlayState(fsm, actionOnPause: actionOnPause))
    }

    func prepareToPlay() {}

    func attemptFailover(from error: BBCSMPError) {
        fsm?.transition(to: FSMPausedRetryItemLoadingState(fsm, error, actionOnPause: actionOnPause))
    }

    func seek(to time: TimeInterval, on player: BBCSMP) {
        fsm?.actionWhenReady = {
            self.fsm?.decoder?.scrub(toAbsoluteTime: time)
        }
    }
    func decoderDidProgress(to position: DecoderCurrentPosition) {}
}
