//
//  FSMErrorState.swift
//  SMP
//
//  Created by Matt Mould on 18/12/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

class FSMErrorState: FSMState {
    let publicState = SMPPublicState.error()
    weak var fsm: FSM?
    let error: BBCSMPError

    init(_ fsm: FSM?, _ error: BBCSMPError) {
        self.fsm = fsm
        self.error = error
    }

    func notifyErrorObserver(_ observer: BBCSMPErrorObserver) {
        observer.errorOccurred(error)
    }

    func didBecomeActive() {
        self.fsm?.announceError(error)
    }

    func prepareToPlay() {
        self.fsm?.loadPlayerItem()
    }

    func loadPlayerItem() {
        fsm?.transition(to: FSMItemLoadingState(self.fsm))
    }

    func play() {
        self.fsm?.autoplay = true
        self.fsm?.loadPlayerItem()
    }

    func pause() {}

    func itemLoaded(item: BBCSMPItem) {}
}
