//
//  FSMIdleState.swift
//  SMP
//
//  Created by Matt Mould on 18/12/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

class FSMIdleState: FSMState {
    weak var fsm: FSM?
    let publicState = SMPPublicState.idle()
    let error: BBCSMPError?

    init(_ fsm: FSM?, error: BBCSMPError?=nil) {
        self.fsm = fsm
        self.error = error
    }

    func loadPlayerItem() {
         fsm?.transition(to: FSMItemLoadingState(self.fsm))
    }

    func loadPlayerItemMetadataFailed(_ error: BBCSMPError) {
        fsm?.announceError(error)
        fsm?.transition(to: FSMIdleState(fsm, error: error))
    }

    func stop() {}

    func notifyErrorObserver(_ observer: BBCSMPErrorObserver) {
        guard let error = self.error else {return}
        fsm?.announceError(error)
    }

    func prepareToPlay() {
        loadPlayerItem()
    }

    func play() {
        self.fsm?.autoplay = true
        loadPlayerItem()
    }

    func seek(to time: TimeInterval, on player: BBCSMP) {}

    func addObserver(_ observer: BBCSMPObserver, player: BBCSMP, seekableRange: BBCSMPTimeRange) {}
}
