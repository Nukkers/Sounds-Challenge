//
//  FSMEndedState.swift
//  SMP
//
//  Created by Matt Mould on 18/12/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

class FSMEndedState: NSObject, FSMState {
    weak var fsm: FSM?
    let publicState = SMPPublicState.ended()

    init(_ fsm: FSM?) {
        self.fsm = fsm
    }

    func decoderBuffering(_ isBuffering: Bool) {}

    func play() {
        fsm?.methodsNotMigratedToFSM?.stop()
        fsm?.play()
    }
}
