//
//  FSMItemLoadingState.swift
//  SMP
//
//  Created by Matt Mould on 18/12/2018.
//  Copyright © 2018 BBC. All rights reserved.
//

import Foundation

class FSMItemLoadingState: FSMState {

    let publicState = SMPPublicState.loadingItem()
    weak var fsm: FSM?

    init(_ fsm: FSM?) {
        self.fsm = fsm
    }

    func didBecomeActive() {
        guard let unwrappedPlayerItemProvider = fsm?.playerItemProvider else {return}
        fsm?.playerItemRequester.requestItem(itemProvider: unwrappedPlayerItemProvider,
                                                    success: { (item) in
            guard let resolvedItem = item else {
                let error = NSError(domain: "smp-ios", code: 0, userInfo: nil)
                self.fsm?.itemProviderDidFailToLoadItem(BBCSMPError(error, reason: .initialLoadFailed))
                return
            }
            self.fsm?.itemLoaded(item: resolvedItem)
        }, failure: { (error) in
            var errorReason = BBCSMPErrorEnumeration.mediaResolutionFailed
            let networkParseFailureErrorCode = 3840
            if error?._domain == NSCocoaErrorDomain && error?._code == networkParseFailureErrorCode {
                errorReason = BBCSMPErrorEnumeration.initialLoadFailed
            }
            let errorForSMP: Error
            if let itemProviderError = error {
                errorForSMP = itemProviderError
            } else {
                errorForSMP = NSError(domain: "smp-ios", code: 0, userInfo: nil)
            }
            self.fsm?.itemProviderDidFailToLoadItem(BBCSMPError(errorForSMP, reason: errorReason))
        })
    }

    func itemLoaded(item: BBCSMPItem) {
        fsm?.transition(to: FSMItemLoadedState(fsm, item: item))
    }

    func play() {
        self.fsm?.autoplay = true
    }

    func itemProviderDidFailToLoadItem(_ error: BBCSMPError) {
        fsm?.transition(to: FSMIdleState(fsm, error: error))
        fsm?.announceError(error)
        fsm?.methodsNotMigratedToFSM?.itemProviderDidFailToLoadItemWithError(error.error)
    }

    func seek(to time: TimeInterval, on player: BBCSMP) {
        fsm?.actionWhenReady = { [unowned player] in
            player.scrub(to: time)
        }
    }

    func pause() {
        fsm?.methodsNotMigratedToFSM?.stop()
    }
}
