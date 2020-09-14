//
//  AVPlayerLogger.swift
//  SMP
//
//  Created by Ryan Johnstone on 18/11/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation
import AVFoundation

@objc(BBCSMPLoggingAVPlayer)
public class LoggingAVPlayer: AVPlayer  {

    public override func seek(to time: CMTime, toleranceBefore: CMTime, toleranceAfter: CMTime, completionHandler: @escaping (Bool) -> Void) {
        print("AVPlayer Logger - seek to time: \(time.seconds)")
        super.seek(to: time, toleranceBefore: toleranceBefore, toleranceAfter: toleranceAfter, completionHandler: completionHandler)
    }
}
