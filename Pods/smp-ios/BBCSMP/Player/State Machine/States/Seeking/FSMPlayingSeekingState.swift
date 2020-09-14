//
//  FSMPlayingSeeingState.swift
//  SMP
//
//  Created by Matt Mould on 08/03/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

class FSMPlayingSeekingState: NSObject, FSMState {

    let publicState = SMPPublicState.buffering()
    weak var fsm: FSM?

    init(_ fsm: FSM?) {
        self.fsm = fsm
    }

    func decoderPlaying() {
        fsm?.transition(to: FSMPlayingState(fsm))
    }

    func decoderPaused() {

    }

    func decoderDidProgress(to position: DecoderCurrentPosition) {}

    func pause() {
        fsm?.decoder?.pause()
        fsm?.transition(to: FSMPausedSeekingState(fsm))
    }

    func seek(to time: TimeInterval, on player: BBCSMP) {
        fsm?.pendingSeek = { [weak player, weak fsm] in
            player?.scrub(to: time)
            fsm?.pendingSeek = {}
        }
    }

    func formulateStateRestorationWhenRecovered(player: BBCSMP) {
        let timeToReturnToWhenReady = player.time
        weak var weakReferenceToPlayer = player
        fsm?.actionWhenReady = {
            self.fsm?.play()
            guard let storedTime = timeToReturnToWhenReady else {return}
            weakReferenceToPlayer?.scrub(to: storedTime.seconds)
        }
    }

}
