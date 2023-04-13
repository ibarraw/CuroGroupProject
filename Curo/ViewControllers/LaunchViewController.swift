//
//  LaunchViewController.swift
//  Curo
//
//  Created by John Ho on 2023-04-11.
//

import UIKit
import AVKit

class LaunchViewController: UIViewController {
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //show video in background
        setUpVideo()
    }
    
    func setUpElements() {
        
    }
    
    func setUpVideo() {
        //get the path to resource in bundle
        let bundlePath = Bundle.main.path(forResource: "curoBg", ofType: "mp4")
        guard bundlePath != nil else {
            return
        }
        
        //create a url
        let url = URL(fileURLWithPath: bundlePath!)
        
        //create video player item
        let item = AVPlayerItem(url: url)
        
        //create the player
        videoPlayer = AVPlayer(playerItem: item)
        
        //create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        //adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x:
                                            -self.view.frame.size.width*1.5, y:0,width:
                                            self.view.frame.width*4, height: self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        //add to view and play
        videoPlayer?.playImmediately(atRate: 0.3)
        
    }

}
