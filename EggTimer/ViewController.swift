//
//  ViewController.swift
//  EggTimer
//
//  Created by Damir Zaripov on 05.04.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = [
        "Soft": 300,
        "Medium": 420,
        "Hard": 720,
    ]
    
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleText: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        stopSound()
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        progressBar.progress = 0.0
        secondsPassed = 0
        titleText.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
            
            if secondsPassed < totalTime {
                secondsPassed += 1
                let percentageProgress = Double(secondsPassed) / Double(totalTime)
                progressBar.setProgress(Float(percentageProgress), animated: true)
            }
            else {
                timer.invalidate()
                playSound()
                titleText.text = "Get it out!"
                
            }
        }
        
        func playSound() {
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
            
        }
        func stopSound() {
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.stop()
        }
    }
}

