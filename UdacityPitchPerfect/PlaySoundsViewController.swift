//
//  ViewController.swift
//  UdacityPitchPerfect
//
//  Created by Hamed.Gh on 9/28/17.
//  Copyright © 2017 Hamed.Gh. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var snailBtn: UIButton!
    @IBOutlet weak var chipmunkBtn: UIButton!
    @IBOutlet weak var rabbitBtn: UIButton!
    @IBOutlet weak var vaderBtn: UIButton!
    @IBOutlet weak var echoBtn: UIButton!
    @IBOutlet weak var reverbBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    
    var recordedAudioUrl: URL!
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK: Actions
    
    @IBAction func playSoundForBtn(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }

        configureUI(.playing)
    }
    
    @IBAction func stopBtnPressed(_ sender: AnyObject) {
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
        makeImgOfBtnScaleAspectFit()
    }
    
    
    func makeImgOfBtnScaleAspectFit() {
        self.snailBtn.imageView?.contentMode = .scaleAspectFit
        self.rabbitBtn.imageView?.contentMode = .scaleAspectFit
        self.chipmunkBtn.imageView?.contentMode = .scaleAspectFit
        self.vaderBtn.imageView?.contentMode = .scaleAspectFit
        self.reverbBtn.imageView?.contentMode = .scaleAspectFit
        self.echoBtn.imageView?.contentMode = .scaleAspectFit
        
        self.stopBtn.imageView?.contentMode = .scaleAspectFit
    }

}

