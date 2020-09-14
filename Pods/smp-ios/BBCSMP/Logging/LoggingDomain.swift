//
//  Tracer.swift
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/12/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

@objc(BBCLoggingDomain)
public class LoggingDomain: NSObject {

    private let logWriterFactory: LogWriterFactory
    private let domain: String
    private var subdomainLoggers = [String: Logger]()

    init(logWriterFactory: LogWriterFactory, domain: String) {
        self.logWriterFactory = logWriterFactory
        self.domain = domain
    }

    @objc public convenience init(domain: String) {
        self.init(logWriterFactory: VersionSensitiveLogWriterFactory(), domain: domain)
    }

    @objc public func logger() -> Logger {
        return logger(subdomain: "")
    }

    @objc public func logger(subdomain: String) -> Logger {
        if let existingLogger = subdomainLoggers[subdomain] {
            return existingLogger
        } else {
            let writer = logWriterFactory.makeLogWriter(domain: domain, subdomain: subdomain)
            let logger = Logger(writer: writer)
            subdomainLoggers[subdomain] = logger

            return logger
        }
    }

}
