//
//  FSMBufferingSeekingState.swift
//  SMP
//
//  Created by Matt Mould on 13/03/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

class FSMBufferingSeekingState: NSObject, FSMState {

    let publicState = SMPPublicState.buffering()
    weak var fsm: FSM?

    init(_ fsm: FSM?) {
        self.fsm = fsm
    }

    func decoderPlaying() {
        fsm?.transition(to: FSMPlayingState(fsm))
    }

    func decoderPaused() {
        fsm?.transition(to: FSMPausedState(fsm))
    }

    func seek(to time: TimeInterval, on player: BBCSMP) {
        fsm?.pendingSeek = { [weak player, weak fsm] in
            player?.scrub(to: time)
            fsm?.pendingSeek = {}
        }

    }

    func decoderDidProgress(to position: DecoderCurrentPosition) {}

    func formulateStateRestorationWhenRecovered(player: BBCSMP) {
        let timeToReturnToWhenReady = player.time
        fsm?.actionWhenReady = {[weak player] in
            guard let storedTime = timeToReturnToWhenReady else {return}
            player?.scrub(to: storedTime.seconds)
        }
    }

}
