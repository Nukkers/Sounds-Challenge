//
//  FSMPlayerReadyState.swift
//  SMP
//
//  Created by Matt Mould on 18/12/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

class FSMPlayerReadyState: FSMState {
    let publicState = SMPPublicState.playerReady()
    weak var fsm: FSM?

    init(_ fsm: FSM?) {
        self.fsm = fsm
    }

    func didBecomeActive() {
        let localActionWhenReady = fsm?.actionWhenReady
        fsm?.actionWhenReady = {}
        localActionWhenReady?()
    }

    func play() {
        self.fsm?.decoder?.play()
    }

    func formulateStateRestorationWhenRecovered(player: BBCSMP) {
        let timeToReturnToWhenReady = player.time
        weak var weakReferenceToPlayer = player
        fsm?.actionWhenReady = {
            guard let storedTime = timeToReturnToWhenReady else {return}
            weakReferenceToPlayer?.scrub(to: storedTime.seconds)
        }
    }

    func seek(to time: TimeInterval, on player: BBCSMP) {
        fsm?.transition(to: FSMReadySeekingState(fsm))
        fsm?.decoder?.scrub(toAbsoluteTime: time)
    }
}
