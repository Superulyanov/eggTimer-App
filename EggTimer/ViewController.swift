//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.


import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    var timer = Timer()
    
    let eggDict = ["Soft" : 3, "Medium" : 5, "Hard" : 7]
    var secondRemaning = 60
    var totalTime = 0
    var passedTime = 0

    @IBOutlet var timerOutlet: UILabel!
    @IBOutlet var stopButtonOutlet: UIButton!
    @IBOutlet var progressBarOutlet: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        stopButtonOutlet.layer.cornerRadius = 10
    }
    
    func playerPlaySound(soundName: String) {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }

    func stopPlaySound(){
            player.stop()
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {

        timer.invalidate()
        
        var hardness = sender.currentTitle!
        
        secondRemaning = eggDict[hardness]!
        totalTime = eggDict[hardness]!
        
        var result = print(eggDict[hardness]!)

        
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,target: self,selector: #selector(updateTimer),
userInfo: nil,repeats: true)
        
    }

    @objc func updateTimer(){
        //timerOutlet.text = String(Int(secondRemaning))
        if secondRemaning > 0 && passedTime < totalTime {
        print("\(secondRemaning) seconds.")
            secondRemaning -= 1
            timerOutlet.text = String(Int(secondRemaning))
            
            passedTime += 1
            let percentProgress = (Float(passedTime) / Float(totalTime))
       
            progressBarOutlet.progress = percentProgress
            print(Float(percentProgress))
            
            
        } else if secondRemaning == 0 {
            playerPlaySound(soundName: "alarm_sound")
            timerOutlet.text = "DONE"
        }

    }

    @IBAction func stopButtonAction(_ sender: UIButton) {
        timer.invalidate()
        stopPlaySound()
        timerOutlet.text = "0"
        progressBarOutlet.progress = 0
        passedTime = 0
    }
    
    }
    



