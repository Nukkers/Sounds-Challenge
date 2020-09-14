//
//  FSMRetryItemLoadingState.swift
//  SMP
//
//  Created by Shahnaz Hameed on 28/06/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

class FSMPausedRetryItemLoadingState: FSMState {

    let publicState = SMPPublicState.paused()
    weak var fsm: FSM?
    let error: BBCSMPError
    let actionOnPause: (_ state: FSMState) -> Void

    init(_ fsm: FSM?, _ error: BBCSMPError, actionOnPause: @escaping (_ state: FSMState) -> Void) {
        self.fsm = fsm
        self.error = error
        self.actionOnPause = actionOnPause
    }

    func itemLoaded(item: BBCSMPItem) {
        error.recovered = true
        fsm?.announceError(error)
        fsm?.transition(to: FSMPausedRetryItemLoadedState(fsm, item: item, actionOnPause: actionOnPause))
    }

    func play() {
        self.fsm?.autoplay = true
        fsm?.transition(to: FSMRetryItemLoadingState(fsm, error, actionOnPause: actionOnPause))
    }

    func seek(to time: TimeInterval, on player: BBCSMP) {
        fsm?.actionWhenReady = { [unowned player] in
            player.scrub(to: time)
        }
    }

    func attemptFailover(from error: BBCSMPError) {
        fsm?.transition(to: FSMPausedRetryItemLoadingState(fsm, error, actionOnPause: actionOnPause))
    }
    func decoderDidProgress(to position: DecoderCurrentPosition) {}
}
