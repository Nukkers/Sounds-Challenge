//
//  FSMRetryItemLoadingState.swift
//  SMP
//
//  Created by Shahnaz Hameed on 28/06/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

class FSMRetryItemLoadingState: FSMState {

    let publicState = SMPPublicState.buffering()
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
        fsm?.transition(to: FSMRetryItemLoadedState(fsm, item: item, actionOnPause: actionOnPause))
    }

    func play() {
        self.fsm?.autoplay = true
    }

    func seek(to time: TimeInterval, on player: BBCSMP) {
        fsm?.actionWhenReady = { [unowned player] in
            player.scrub(to: time)
        }
    }

    func pause() {
        actionOnPause(FSMPausedRetryItemLoadingState(fsm, error, actionOnPause: actionOnPause))
    }

    func decoderPaused() {
        actionOnPause(FSMPausedRetryItemLoadingState(fsm, error, actionOnPause: actionOnPause))
    }
    func decoderDidProgress(to position: DecoderCurrentPosition) {}
}
