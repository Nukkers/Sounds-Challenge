//
//  FSMItemLoadedState.swift
//  SMP
//
//  Created by Matt Mould on 18/12/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

class FSMItemLoadedState: NSObject, FSMState {
    let publicState = SMPPublicState.itemLoaded()
    weak var fsm: FSM?
    let item: BBCSMPItem

    init(_ fsm: FSM?, item: BBCSMPItem) {
        self.fsm = fsm
        self.item = item
    }

    func didBecomeActive() {
        self.fsm?.methodsNotMigratedToFSM?.itemProviderDidLoadItem(self.item)
    }

    func prepareToPlay() {
        fsm?.transition(to: FSMPreparingToPlayState(fsm))
    }

    func seek(to time: TimeInterval, on player: BBCSMP) {
        fsm?.actionWhenReady = {
            self.fsm?.decoder?.scrub(toAbsoluteTime: time)
        }
    }

}
