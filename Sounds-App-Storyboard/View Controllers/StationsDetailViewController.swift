//
//  DetailViewController.swift
//  Sounds-App-Storyboard
//
//  Created by Naukhez Ali on 11/09/2020.
//  Copyright © 2020 Naukhez Ali. All rights reserved.
//

import UIKit
import SMP

class StationsDetailViewController: UIViewController, Storyboarded {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    weak var coordinator: MainCoordinator?
    var soundsData: RMSPlayableItem?
    
    var player: BBCSMP?
    var stationsDetailVM: StationsDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setUI()
        
        stationsDetailVM = StationsDetailViewModel()
        stationsDetailVM?.mediaPlayerReadyDelegate = self
        
        let myId = (soundsData?.id)!
        
       stationsDetailVM?.setUpPlayer(id: myId)
        
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

extension StationsDetailViewController: MediaPlayerReadyDelegate {
    func MediaPlayerReady(mediaPlayer: BBCSMP) {
        self.player = mediaPlayer
    }
    
}
