//
//  AudioRecord.swift
//  QRMedia
//
//  Created by Loreto Dumitrescu on 2/2/15.
//  Copyright (c) 2015 Loreto Dumitrescu. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


class AudioRecordViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    //create audio player and recorder
    var audioPlayer:AVAudioPlayer?
    var audioRecorder:AVAudioRecorder?
    
    //Record,stop, and play buttons
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    //recording time display
    @IBOutlet weak var audioTime: UILabel!

    
    //prepare to record
    //var error: NSError?
    //recorder.recording = AVAudioRecorder(URL: soundFileURL, settings: recordSettings, error: &error)
    //if e = error {
      //  println(error.localizedDescription)
    //} else {
    //recorder.delegate = self
    //recorder.meteringEnabled = true
    //recorder.prepareToRecord() // creates/overwrites the file at soundFileURL
    //}
    
    //permission to record
    //AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
    //if granted {
    //self.setSessionPlayAndRecord()
    //self.setupRecorder()
    //self.recorder.record()
    //self.meterTimer = NSTimer.scheduledTimerWithTimeInterval(0.1,
    //target:self,
    //selector:"updateAudioMeter:",
    //userInfo:nil,
    //repeats:true)
    //} else {
    //println("Permission to record not granted")
    //}
    //})
    
    //recording time display
    //func updateAudioMeter(timer:NSTimer) {
      //  if recorder.recording {
        //    let dFormat = "%02d"
          //  let min:Int = Int(recorder.currentTime / 60)
            //let sec:Int = Int(recorder.currentTime % 60)
            //let s = "\(String(format: dFormat, min)):\(String(format: dFormat, sec))"
            //statusLabel.text = s
            //recorder.updateMeters()
            //var apc0 = recorder.averagePowerForChannel(0)
            //var peak0 = recorder.peakPowerForChannel(0)
            //println(min:Int, sec:Int)
        //}
    //}

    
//    @IBAction func record() {
//            
//            //declare instance variable
//            var audioRecorder:AVAudioRecorder!
//            
//            var audioSession:AVAudioSession = AVAudioSession.sharedInstance()
//            audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
//            audioSession.setActive(true, error: nil)
//            
//            var documents: AnyObject = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory,  NSSearchPathDomainMask.UserDomainMask, true)[0]
//            var str =  documents.stringByAppendingPathComponent("recordTest.caf")
//            var url = NSURL.fileURLWithPath(str as String)
//            
//            var recordSettings = [AVFormatIDKey:kAudioFormatAppleIMA4,
//                AVSampleRateKey:44100.0,
//                AVNumberOfChannelsKey:2,AVEncoderBitRateKey:12800,
//                AVLinearPCMBitDepthKey:16,
//                AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue
//                
//            ]
//            
//            println("url : \(url)")
//            var error: NSError?
//            
//            audioRecorder = AVAudioRecorder(URL:url, settings: recordSettings, error: &error)
//            if let e = error {
//                println(e.localizedDescription)
//            } else {
//                audioRecorder.record()
//            }
//
//    }

        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton.enabled = false
        stopButton.enabled = false
        
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        let docsDir = dirPaths[0] as String
        let soundFilePath =
        docsDir.stringByAppendingPathComponent("sound.caf")
        let soundFileURL = NSURL(fileURLWithPath: soundFilePath)
        let recordSettings =
        [AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0]
        
        var error: NSError?
        
        let audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord,
            error: &error)
        
        if let err = error {
            println("audioSession error: \(err.localizedDescription)")
        }
        
        audioRecorder = AVAudioRecorder(URL: soundFileURL,
            settings: recordSettings, error: &error)
        
        if let err = error {
            println("audioSession error: \(err.localizedDescription)")
        } else {
            audioRecorder?.prepareToRecord()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordButton(sender: AnyObject) {
        if audioRecorder?.recording == false {
            playButton.enabled = false
            stopButton.enabled = true
            audioRecorder?.record()
        }
    }
    
    @IBAction func stopButton(sender: AnyObject) {
        stopButton.enabled = false
        playButton.enabled = true
        recordButton.enabled = true
        
        if audioRecorder?.recording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
        }

    }
    
    @IBAction func playButton(sender: AnyObject) {
        if audioRecorder?.recording == false {
            stopButton.enabled = true
            recordButton.enabled = false
            
            var error: NSError?
            
            audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder?.url,
                error: &error)
            
            audioPlayer?.delegate = self
            
            if let err = error {
                println("audioPlayer error: \(err.localizedDescription)")
            } else {
                audioPlayer?.play()
            }
        }
    }
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        recordButton.enabled = true
        stopButton.enabled = false
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("Audio Play Decode Error")
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        println("Audio Record Encode Error")
    }
}


