//
//  LogFactory.swift
//  SMP
//
//  Created by Thomas Sherwood - TV&Mobile Platforms - Core Engineering on 21/12/2017.
//  Copyright © 2017 BBC. All rights reserved.
//

public protocol LogWriterFactory {

    func makeLogWriter(domain: String, subdomain: String) -> LogWriter

}
