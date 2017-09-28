//
//  RecordSoundsViewController2.swift
//  UdacityPitchPerfect
//
//  Created by Hamed.Gh on 9/28/17.
//  Copyright © 2017 Hamed.Gh. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet var recordingLbl: UILabel!
    @IBOutlet var recordBtn: UIButton!
    @IBOutlet var stopRecordingBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopRecordingBtn.isEnabled = false
    }
    
    @IBAction func recordBtn(_ sender: Any) {
        recordingLbl.text = "Recording in Progress"
        stopRecordingBtn.isEnabled = true
        recordBtn.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        stopRecordingBtn.isEnabled = false
        recordBtn.isEnabled = true
        recordingLbl.text = "Tap to Record"
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("finished Recording")
        if flag {
            performSegue(withIdentifier:"stopRecording", sender: audioRecorder.url)
        }
        else {
            print("recording was not successful")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            //let recordedAudioUrl = sender as! URL
            let recordedAudioUrl = audioRecorder.url
            playSoundsVC.recordedAudioUrl = recordedAudioUrl
            
        }
    }
}
