//
//  FSMStoppingState.swift
//  SMP
//
//  Created by Matt Mould on 20/12/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

class FSMStoppingState: NSObject, FSMState {
    weak var fsm: FSM?
    let publicState = SMPPublicState.stopping()

    init(_ fsm: FSM?) {
        self.fsm = fsm
    }

    func didBecomeActive() {
        fsm?.transition(to: FSMIdleState(fsm))
    }
}
