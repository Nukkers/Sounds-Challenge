//
//  FSMPausedSeekingState.swift
//  SMP
//
//  Created by Matt Mould on 08/03/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

class FSMReadySeekingState: NSObject, FSMState {

    let publicState = SMPPublicState.playerReady()
    weak var fsm: FSM?

    init(_ fsm: FSM?) {
        self.fsm = fsm
    }

    func decoderPlaying() {
        fsm?.transition(to: FSMPlayingState(fsm))
    }

    func decoderPaused() {
        fsm?.transition(to: FSMPlayerReadyState(fsm))
    }

    func decoderDidProgress(to position: DecoderCurrentPosition) {}

    func play() {
        fsm?.decoder?.play()
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
            self.fsm?.pause()
            guard let storedTime = timeToReturnToWhenReady else {return}
            weakReferenceToPlayer?.scrub(to: storedTime.seconds)
        }
    }

}
