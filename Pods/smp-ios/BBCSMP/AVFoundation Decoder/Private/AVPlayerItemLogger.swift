//
//  AVPlayerItemLogger.swift
//  SMP
//
//  Created by Emma Walker - TVandMobile Platforms - Core Engineering on 15/11/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation
import AVFoundation

@objc(BBCSMPAVPlayerItemLogger)
public class AVPlayerItemLogger: AVPlayerItem  {
    
    public override var seekableTimeRanges: [NSValue] {
        
        let ranges = super.seekableTimeRanges
        print("AVPlayerItemLogger - seekableTimeRanges \(ranges)")
        
        return ranges
    }

    public override func seek(to time: CMTime, toleranceBefore: CMTime, toleranceAfter: CMTime, completionHandler: ((Bool) -> Void)? = nil) {
        print("AVPlayerItemLogger - seek to time: \(time.seconds)")
        super.seek(to: time, toleranceBefore: toleranceBefore, toleranceAfter: toleranceAfter, completionHandler: completionHandler)
    }

    public override func cancelPendingSeeks() {
        print("AVPlayerItemLogger - cancelPendingSeeks")
        super.cancelPendingSeeks()
    }

    public override var loadedTimeRanges: [NSValue] {
        let ranges = super.loadedTimeRanges
        print("AVPlayerItemLogger - loadedTimeRanges \(ranges)")

        return ranges
    }

}
