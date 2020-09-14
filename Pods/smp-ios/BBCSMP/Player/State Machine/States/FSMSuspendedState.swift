//
//  FSMSuspendedState.swift
//  SMP
//
//  Created by Matt Mould on 18/01/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

class FSMSuspendedState: FSMState {
    weak var fsm: FSM?
    let publicState = SMPPublicState.paused()

    init(_ fsm: FSM?) {
        self.fsm = fsm
    }

    func play() {
        self.fsm?.stop()
        self.fsm?.autoplay = true
        self.fsm?.prepareToPlay()
    }

    func didResignActive() {
        self.fsm?.suspendMechanism.cancelPendingSuspendTransition()
    }

    func seek(to time: TimeInterval, on player: BBCSMP) {
        fsm?.actionWhenReady = { [unowned player] in
            player.scrub(to: time)
        }
    }
}
