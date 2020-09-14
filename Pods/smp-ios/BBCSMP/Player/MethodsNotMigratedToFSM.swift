//
//  MethodsNotMigratedToFSM.swift
//  SMP
//
//  Created by Ryan Johnstone on 17/01/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

/*
 The purpose of this interface is to facilitate the migration of stateful behaviour from the
 SMPPlayer to FSM, allowing FSM to call SMPPlayer when needed.
 */
@objc public protocol MethodsNotMigratedToFSM {
    func itemProviderDidLoadItem(_ item: BBCSMPItem)
    func itemProviderDidFailToLoadItemWithError(_ error: Error)
    func preparePlayerForCurrentPlayerItem()
    func stop()
    func setTimeOnPlayerContext(_ position: DecoderCurrentPosition)
}
