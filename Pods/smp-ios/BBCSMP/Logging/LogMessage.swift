//
//  LogMessage.swift
//  BBCSMPTests
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/12/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

@objc(BBCLogMessage)
public protocol LogMessage {

    func createLogMessage() -> String

}
