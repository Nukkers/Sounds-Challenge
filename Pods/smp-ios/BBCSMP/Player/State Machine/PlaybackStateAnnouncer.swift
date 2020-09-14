//
//  PlaybackStateAnnouncer.swift
//  SMP
//
//  Created by Matt Mould on 30/04/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

class PlaybackStateAnnouncer {

    private lazy var stateAnnouncementPredicate: (FSMState) -> Bool = null
    private lazy var readyStatePredicate: (FSMState) -> Bool = ignoreReadyState

    private var publicStateObservers: [PlaybackStateObserver] = []
    private var currentPublicState: PlaybackState = PlaybackStateUnprepared()
    private var currentState: FSMState?

    func playRequested() {
        readyStatePredicate = ignoreReadyState
    }

    func addObserver(_ observer: PlaybackStateObserver) {
        publicStateObservers.append(observer)
        publicStateObservers.forEach { $0.state(currentPublicState) }
    }

    func removeObserver(_ observer: PlaybackStateObserver) {
        publicStateObservers.removeAll { (observerInList) -> Bool in
            observerInList.isEqual(observer)
        }
    }

    private func announcePublicState(_ state: PlaybackState) {
        print("Announcing public state \(state)")
        guard type(of: state) != type(of: currentPublicState) else {
            return
        }
        publicStateObservers.forEach { $0.state(state) }
        currentPublicState = state
    }

    func stateChanged(_ state: FSMState) {
        guard stateAnnouncementPredicate(state) else {return}
        guard readyStatePredicate(state) else {return}

        switch state {
        case is FSMIdleState:
            self.announcePublicState(PlaybackStateUnprepared())
        case is FSMItemLoadingState,
             is FSMBufferingState,
             is FSMRetryItemLoadingState,
             is FSMRetryItemLoadedState,
             is FSMRetryPreparingToPlayState,
             is FSMPlayingSeekingState:
            self.announcePublicState(PlaybackStateLoading())
        case is FSMPlayingState:
            readyStatePredicate = ignoreReadyState
            self.announcePublicState(PlaybackStatePlaying())
        case is FSMPausedState,
             is FSMInterruptedState,
             is FSMPlayerReadyState,
             is FSMPausedRetryPreparingToPlayState,
             is FSMPausedRetryItemLoadingState:
            readyStatePredicate = null
            self.announcePublicState(PlaybackStatePaused())
        case is FSMErrorState:
            self.announcePublicState(PlaybackStateFailed())
        case is FSMEndedState:
            self.announcePublicState(PlaybackStateEnded())
        case is FSMSuspendedState:
            stateAnnouncementPredicate = waitForLoadingState
        case is FSMPausedSeekingState:
            if currentState is FSMPlayingSeekingState {
                self.announcePublicState(PlaybackStatePaused())
            }
        default:
            break
        }

        self.currentState = state
    }

    private lazy var waitForLoadingState: (FSMState) -> Bool =  { [unowned self]  (state) in
        if state is FSMItemLoadingState {
            self.stateAnnouncementPredicate = self.null
            return true
        }
        return false
    }

    private lazy var ignoreReadyState:(FSMState) -> Bool = {
        [unowned self]  (state) in
        return !(state is FSMPlayerReadyState)
    }

    private lazy var null:(FSMState) -> Bool = {
        [unowned self]  (_) in
        return true
    }
}
