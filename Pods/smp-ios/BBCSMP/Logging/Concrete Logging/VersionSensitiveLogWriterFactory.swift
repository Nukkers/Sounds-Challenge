//
//  VersionSensitiveLogWriterFactory.swift
//  BBCSMPTests
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/12/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

struct VersionSensitiveLogWriterFactory: LogWriterFactory {

    func makeLogWriter(domain: String, subdomain: String) -> LogWriter {
        if #available(iOS 10.0, *) {
            return UniversalLog(domain: domain, subdomain: subdomain)
        } else {
            return NSLogWriter(domain: domain, subdomain: subdomain)
        }
    }

}
