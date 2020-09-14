//
//  FSMPreparingToPlayState.swift
//  SMP
//
//  Created by Matt Mould on 18/12/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

class FSMPreparingToPlayState: FSMState {
    let publicState = SMPPublicState.preparingToPlay()
    weak var fsm: FSM?

    init(_ fsm: FSM?) {
        self.fsm = fsm
    }

    func prepareToPlay() {}

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
        fsm?.methodsNotMigratedToFSM?.stop()
    }

    func attemptFailover(from error: BBCSMPError) {
        fsm?.transition(to: FSMRetryItemLoadingState(fsm, error) {[weak fsm] (_ state: FSMState) in
             fsm?.methodsNotMigratedToFSM?.stop()
        })
    }

    func seek(to time: TimeInterval, on player: BBCSMP) {
        fsm?.actionWhenReady = { [unowned player] in
            player.scrub(to: time)
        }
    }
}
