//
//  NSLogWriter.swift
//  BBCSMPTests
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/12/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

class NSLogWriter: NSObject, LogWriter {

    private let domain: String
    private let subdomain: String

    init(domain: String, subdomain: String) {
        self.domain = domain
        self.subdomain = subdomain
    }

    private var logPrefix: String {
        return "\(domain):\(subdomain) -"
    }

    var isDebugLoggingEnabled: Bool {
#if DEBUG
        return true
#else
        return false
#endif
    }

    func logMessage(_ message: String) {
        NSLog("%@ INFO - %@", logPrefix, message)
    }

    func logDebugMessage(_ message: String) {
        NSLog("%@ DEBUG - %@", logPrefix, message)
    }

    func logErrorMessage(_ message: String) {
        NSLog("%@ ERROR - %@", logPrefix, message)
    }

}
