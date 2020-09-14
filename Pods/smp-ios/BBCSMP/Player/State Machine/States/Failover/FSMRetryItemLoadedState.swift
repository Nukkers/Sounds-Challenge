//
//  FSMRetryItemLoadedState.swift
//  SMP
//
//  Created by Matt Mould on 26/06/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

class FSMRetryItemLoadedState: NSObject, FSMState {
    let publicState = SMPPublicState.itemLoaded()
    weak var fsm: FSM?
    let item: BBCSMPItem
    let actionOnPause: (_ state: FSMState) -> Void

    init(_ fsm: FSM?, item: BBCSMPItem, actionOnPause: @escaping (_ state: FSMState) -> Void) {
        self.fsm = fsm
        self.item = item
        self.actionOnPause = actionOnPause
    }

    func didBecomeActive() {
        self.fsm?.methodsNotMigratedToFSM?.itemProviderDidLoadItem(self.item)
    }

    func prepareToPlay() {
        fsm?.transition(to: FSMRetryPreparingToPlayState(fsm, actionOnPause: actionOnPause))
    }

    func seek(to time: TimeInterval, on player: BBCSMP) {
        fsm?.actionWhenReady = {
            self.fsm?.decoder?.scrub(toAbsoluteTime: time)
        }
    }
    
    func decoderDidProgress(to position: DecoderCurrentPosition) {}
}
