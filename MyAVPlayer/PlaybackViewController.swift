//
//  PlaybackViewController.swift
//  MyAVPlayer
//
//  Created by knax on 11/1/17.
//  Copyright © 2017 StepwiseDesigns. All rights reserved.
//

import UIKit
import AVKit

class PlaybackViewController: UIViewController {

    var playbackURL: URL?
    let avPlayer = AVPlayer()
    var avPlayerLayer: AVPlayerLayer!
    
    @IBOutlet weak var playbackViewOutlet: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        playVideoItem()
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        avPlayerLayer.frame = view.bounds
        playbackViewOutlet.layer.insertSublayer(avPlayerLayer, at: 0)
        
    }
    
    func playVideoItem(){
        avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
       
        guard let playbackURL =  playbackURL else {
            return
        }
        let playerItem = AVPlayerItem(url: playbackURL)
        avPlayer.replaceCurrentItem(with: playerItem)
        avPlayer.play()
    }
}
