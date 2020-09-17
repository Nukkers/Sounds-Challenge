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

class DetailViewController: UIViewController {

    @IBOutlet weak var SoundImageView: UIImageView!
    @IBOutlet weak var SoundDetailLabel: UILabel!
    @IBOutlet weak var PlayButton: UIButton!
    @IBOutlet weak var PauseButton: UIButton!
    
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
        SoundDetailLabel.text = soundsData?.titles.primary

//        // Load the image from remote URL
//        if let url = URL(string: soundsData!.image_url){
//            SoundImageView.load(url: url)
//        }
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        player?.play()
    }
    @IBAction func pauseButtonTapped(_ sender: Any) {
        player?.pause()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
