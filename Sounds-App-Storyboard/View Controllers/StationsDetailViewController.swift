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
    
    var player: BBCSMP?
    var stationsDetailVM: StationsDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUI()
        
        stationsDetailVM?.mediaPlayerReadyDelegate = self
        
        stationsDetailVM?.setUpPlayer()
    }
    
    func setUI() {
        detailLabel.text  = stationsDetailVM?.primaryTitle
        // Load the image from remote URL
        imageView.load(url: stationsDetailVM!.image)
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
