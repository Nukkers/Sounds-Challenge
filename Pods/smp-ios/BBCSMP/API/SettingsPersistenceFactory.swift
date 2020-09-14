//
//  SettingsPersistenceFactory.swift
//  SMP
//
//  Created by Ross Beazley on 05/04/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

@objc(BBCSMPSettingsPersistenceFactory)
public protocol SettingsPersistenceFactory {
    func create(withDefaultValue: Bool) -> BBCSMPSettingsPersistence
}
