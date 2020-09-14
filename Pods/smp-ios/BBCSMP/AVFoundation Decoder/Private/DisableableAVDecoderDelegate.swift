//
//  DisableableAVdecoderDelegate?.swift
//  SMP
//
//  Created by Andrew Wilson-Jones on 18/11/2019.
//  Copyright © 2019 BBC. All rights reserved.
//

import Foundation

@objc (BBCSMPDisableableAVDecoderDelegate)
public class DisableableAVDecoderDelegate: NSObject, BBCSMPDecoderDelegate {

    private weak var decoderDelegate: BBCSMPDecoderDelegate?
    private var decoderHasBeenReady: Bool = false

    @objc
    public init(decoderDelegate: BBCSMPDecoderDelegate) {
        self.decoderDelegate = decoderDelegate
    }

    public func playerState() -> BBCSMPStateEnumeration {
        guard let decoderDelegate = decoderDelegate else { return BBCSMPStateEnumeration.idle }
        return decoderDelegate.playerState()
    }

    public func decoderReady() {
        decoderHasBeenReady = true
        decoderDelegate?.decoderReady()
    }

    public func decoderPlaying() {
        decoderDelegate?.decoderPlaying()
    }

    public func decoderPaused() {
        if decoderHasBeenReady {
            decoderDelegate?.decoderPaused()
        }
    }

    public func decoderBuffering(_ buffering: Bool) {
        decoderDelegate?.decoderBuffering(buffering)
    }

    public func decoderFinished() {
        decoderDelegate?.decoderFinished()
    }

    public func decoderMuted(_ muted: Bool) {
        decoderDelegate?.decoderMuted(muted)
    }

    public func decoderVolumeChange(_ volume: Float) {
        decoderDelegate?.decoderVolumeChange(volume)
    }

    public func decoderVideoRectChanged(_ videoRect: CGRect) {
        decoderDelegate?.decoderVideoRectChanged(videoRect)
    }

    public func decoderBitrateChanged(_ bitrate: Double) {
        decoderDelegate?.decoderBitrateChanged(bitrate)
    }

    public func decoderInterrupted() {
        decoderDelegate?.decoderInterrupted()
    }

    public func decoderPlayingPublicly() {
        decoderDelegate?.decoderPlayingPublicly()
    }

    public func decoderPlayingPrivatley() {
        decoderDelegate?.decoderPlayingPrivatley()
    }

    public func decoderDidProgress(to currentPosition: DecoderCurrentPosition) {
        decoderDelegate?.decoderDidProgress(to: currentPosition)
    }

    public func decoderEventOccurred(_ event: DecoderEvent) {
        decoderDelegate?.decoderEventOccurred?(event)
    }

    public func decoderFailed(error: BBCSMPError) {
        decoderDelegate?.decoderFailed(error: error)
        decoderDelegate = nil
    }

}
