//
//  FSMRetryPreparingToPlayState.swift
//  SMP
//
//  Created by Matt Mould on 26/06/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

class FSMRetryPreparingToPlayState: FSMState {
    let publicState = SMPPublicState.preparingToPlay()
    weak var fsm: FSM?
    let actionOnPause: (_ state: FSMState) -> Void

    init(_ fsm: FSM?, actionOnPause: @escaping (_ state: FSMState) -> Void) {
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
    }

    func pause() {
        actionOnPause(FSMPausedRetryPreparingToPlayState(fsm, actionOnPause: actionOnPause))
    }

    func decoderPaused() {
        actionOnPause(FSMPausedRetryPreparingToPlayState(fsm, actionOnPause: actionOnPause))
    }

    func prepareToPlay() {}

    func seek(to time: TimeInterval, on player: BBCSMP) {
        fsm?.actionWhenReady = {
            self.fsm?.decoder?.scrub(toAbsoluteTime: time)
        }
    }
    
    func decoderDidProgress(to position: DecoderCurrentPosition) {
        
    }

}
