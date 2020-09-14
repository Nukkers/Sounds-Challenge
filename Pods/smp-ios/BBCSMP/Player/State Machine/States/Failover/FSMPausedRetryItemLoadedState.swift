//
//  FSMRetryItemPausedLoadedState.swift
//  SMP
//
//  Created by Shahnaz Hameed on 09/07/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

class FSMPausedRetryItemLoadedState: NSObject, FSMState {
    let publicState = SMPPublicState.itemLoaded()
    weak var fsm: FSM?
    let item: BBCSMPItem
    let actionOnPause: (_ state: FSMState) -> Void

    init(_ fsm: FSM?, item: BBCSMPItem, actionOnPause: @escaping (_ states: FSMState) -> Void) {
        self.fsm = fsm
        self.item = item
        self.actionOnPause = actionOnPause
    }

    func didBecomeActive() {
        self.fsm?.methodsNotMigratedToFSM?.itemProviderDidLoadItem(self.item)
    }

    func prepareToPlay() {
        fsm?.transition(to: FSMPausedRetryPreparingToPlayState(fsm, actionOnPause: actionOnPause))
    }

    func seek(to time: TimeInterval, on player: BBCSMP) {
        fsm?.actionWhenReady = {
            self.fsm?.decoder?.scrub(toAbsoluteTime: time)
        }
    }
    
    func decoderDidProgress(to position: DecoderCurrentPosition) {}

}
