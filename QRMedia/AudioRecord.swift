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


class AudioRecordViewController: UIViewController {
    
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
    @IBOutlet weak var showAudioReview: UIButton!
    
    @IBAction func record() {
            
            //declare instance variable
            var audioRecorder:AVAudioRecorder!
            
            var audioSession:AVAudioSession = AVAudioSession.sharedInstance()
            audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
            audioSession.setActive(true, error: nil)
            
            var documents: AnyObject = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory,  NSSearchPathDomainMask.UserDomainMask, true)[0]
            var str =  documents.stringByAppendingPathComponent("recordTest.caf")
            var url = NSURL.fileURLWithPath(str as String)
            
            var recordSettings = [AVFormatIDKey:kAudioFormatAppleIMA4,
                AVSampleRateKey:44100.0,
                AVNumberOfChannelsKey:2,AVEncoderBitRateKey:12800,
                AVLinearPCMBitDepthKey:16,
                AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue
                
            ]
            
            println("url : \(url)")
            var error: NSError?
            
            audioRecorder = AVAudioRecorder(URL:url, settings: recordSettings, error: &error)
            if let e = error {
                println(e.localizedDescription)
            } else {
                
                audioRecorder.record()
            }

    }
    
    @IBOutlet weak var cancelAudio: UIButton!
    
    @IBOutlet weak var pauseAudio: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

