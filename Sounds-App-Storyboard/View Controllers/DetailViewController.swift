//
//  DetailViewController.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 11/09/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

// TODO - Not sure if pressing back button actually stops the player?

import UIKit
import SMP

class DetailViewController: UIViewController, Storyboarded {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    
    weak var coordinator: MainCoordinator?
    
    // TODO:  - Create station view model - rename DVC to stationViewController
    // Follow the same steps in StationsViewModel and full this code out into a VM
    // This file then owwns the DetailViewContollerViewModel file and makes the calls to that file to get anything it needs
    var soundsData: RMSPlayableItem?
    var VPID: String?
    var player: BBCSMP?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
        
        let myId = soundsData?.id
        VPID = myId

        let playerItemProvider =
            MediaSelectorItemProviderBuilder(
                VPID: VPID!,
                mediaSet: "mobile-phone-main",
                AVType: .audio,
                streamType: .simulcast,
                avStatisticsConsumer: MiniSoundsStatisticsProvider()
            ).buildItemProvider()

        player =
            BBCSMPPlayerBuilder
                .init()
                .withPlayerItemProvider(playerItemProvider)
                .build()
    }
    
    func setUI() {
        detailLabel.text = soundsData?.titles.primary

        // Load the image from remote URL
        imageView.load(url: soundsData!.image_url)
        
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        player?.play()
    }
    @IBAction func pauseButtonTapped(_ sender: Any) {
        player?.pause()
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
