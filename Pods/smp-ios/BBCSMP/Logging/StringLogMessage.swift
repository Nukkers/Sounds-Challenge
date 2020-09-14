//
//  StringLogMessage.swift
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/12/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

@objc(BBCStringLogMessage)
public class StringLogMessage: NSObject, LogMessage {

    private let message: String

    @objc public class func messageWithMessage(_ message: String) -> StringLogMessage {
        return StringLogMessage(message: message)
    }

    @objc public init(message: String) {
        self.message = message
    }

    public func createLogMessage() -> String {
        return message
    }

}
