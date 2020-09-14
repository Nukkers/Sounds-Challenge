//
//  SettingsPersistenceFilesystemFactory.swift
//  SMP
//
//  Created by Ross Beazley on 05/04/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

@objc(BBCSMPSettingsPersistenceFilesystemFactory)
public class SettingsPersistenceFilesystemFactory: NSObject, SettingsPersistenceFactory {

    @objc public var settingsWriteQueue: OperationQueue
    @objc public var settingsFilePath: String

    public override init() {
        settingsWriteQueue = OperationQueue()
        settingsFilePath = BBCSMPSettingsPersistenceFilesystem.defaultSettingsFilePath()
        super.init()
    }

    @objc public func create(withDefaultValue: Bool) -> BBCSMPSettingsPersistence {
       //return BBCSMPSettingsPersistenceFilesystem.sharedDefaultSettingsPersistence(withDefaultValue)
        return BBCSMPSettingsPersistenceFilesystem(settingsWrite: settingsWriteQueue, settingsFilePath: settingsFilePath, defaultUnsetSubsValue: withDefaultValue)
    }

}
