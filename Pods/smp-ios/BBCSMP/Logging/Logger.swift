//
//  Logger.swift
//  BBCSMPTests
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/12/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

@objc(BBCLogLevel)
public enum LogLevel: Int {
    case standard
    case debug
    case error
}

@objc(BBCLogger)
public class Logger: NSObject {

    private let writer: LogWriter

    init(writer: LogWriter) {
        self.writer = writer
    }

    @objc(logMessage:)
    public func log(_ message: LogMessage) {
        log(message, .standard)
    }

    @objc(logMessage:logLevel:)
    public func log(_ message: LogMessage, _ level: LogLevel) {
        switch level {
        case .debug:
            if writer.isDebugLoggingEnabled {
                writer.logDebugMessage(message.createLogMessage())
            }

        case .standard:
            writer.logMessage(message.createLogMessage())

        case .error:
            writer.logErrorMessage(message.createLogMessage())
        }
    }

}
