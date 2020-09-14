//
//  BBCSMPMediaSelectorErrorType.swift
//  SMP
//
//  Created by Sam Rowley on 01/07/2020.
//  Copyright © 2020 BBC. All rights reserved.
//

import Foundation

@objc public enum BBCSMPMediaSelectorErrorType: Int {
    case geolocation
    case generic
}

@objc public class BBCSMPMediaSelectorErrorTransformer: NSObject {
    @objc public static func convertTypeToNSError(_ errorType: BBCSMPMediaSelectorErrorType) -> NSError {
        switch errorType {
        case .generic:
            return NSError(domain: "smp-ios", code: 1052, userInfo: [NSLocalizedDescriptionKey: "Media Resolution Failed"])
        case .geolocation:
            return NSError(domain: "smp-ios", code: 1056, userInfo: [NSLocalizedDescriptionKey: "This content is not available in your location"])
        }
    }
}
