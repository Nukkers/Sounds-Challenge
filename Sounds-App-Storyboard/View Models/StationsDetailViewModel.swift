//
//  StationsDetailViewModel.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 23/09/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import Foundation
import SMP

protocol MediaPlayerReadyDelegate: class {
    func MediaPlayerReady(mediaPlayer: BBCSMP)
}

class StationsDetailViewModel {
    
    weak var mediaPlayerReadyDelegate:
        MediaPlayerReadyDelegate?
    
    var soundsData: RMSPlayableItem
    
    init(data: RMSPlayableItem) {
        self.soundsData = data
    }
    
    public var primaryTitle: String {
        return soundsData.titles.primary
    }
    
    public var image: String {
        return soundsData.image_url
    }
    
    
    func setUpPlayer() {
        let VPID = soundsData.id

        let playerItemProvider =
            MediaSelectorItemProviderBuilder(
                VPID: VPID,
                mediaSet: "mobile-phone-main",
                AVType: .audio,
                streamType: .simulcast,
                avStatisticsConsumer: MiniSoundsStatisticsProvider()
            ).buildItemProvider()

        let player =
            BBCSMPPlayerBuilder
                .init()
                .withPlayerItemProvider(playerItemProvider)
                .build()
        
        mediaPlayerReadyDelegate?.MediaPlayerReady(mediaPlayer: player)
    }
}


// MARK: - Statistics custom class
class MiniSoundsStatisticsProvider: NSObject, BBCSMPAVStatisticsConsumer {
   func trackAVSessionStart(itemMetadata: BBCSMPItemMetadata!) {}
   func trackAVFullMediaLength(lengthInSeconds mediaLengthInSeconds: Int) {}
   func trackAVPlayback(currentLocation: Int, customParameters: [AnyHashable : Any]!) {}
   func trackAVPlaying(subtitlesActive: Bool, playlistTime: Int, assetTime: Int, currentLocation: Int, assetDuration: Int) {}
   func trackAVBuffer(playlistTime: Int, assetTime: Int, currentLocation: Int) {}
   func trackAVPause(playlistTime: Int, assetTime: Int, currentLocation: Int) {}
   func trackAVResume(playlistTime: Int, assetTime: Int, currentLocation: Int) {}
   func trackAVScrub(from fromTime: Int, to toTime: Int) {}
   func trackAVEnd(subtitlesActive: Bool, playlistTime: Int, assetTime: Int, assetDuration: Int, wasNatural: Bool, customParameters: [AnyHashable : Any]!) {}
   func trackAVSubtitlesEnabled(_ subtitlesEnabled: Bool) {}
   func trackAVPlayerSizeChange(_ playerSize: CGSize) {}
   func trackAVError(_ errorString: String!, playlistTime: Int, assetTime: Int, currentLocation: Int, customParameters: [AnyHashable : Any]!) {}
}
