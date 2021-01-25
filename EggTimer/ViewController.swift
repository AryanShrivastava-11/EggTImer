//
//  ViewController.swift
//  EggTimer
//
//  Created by Aryan Shrivastava on 25/01/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let player = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")!)
    
    let eggTime = ["soft" : 5.0,"medium" : 10.0,"hard" : 15.0]
    
    var totalTime = 0.0
    var secondsPassed = 0.0
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        textLabel.text = "How Do You Like Your Eggs?"
        
        player.stop()
        timer.invalidate()
        
        secondsPassed = 0.0
        progressBar.progress = 0.0
        
        totalTime = eggTime[sender.currentTitle!]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timeManager), userInfo: nil, repeats: true)
        
    }
    
    @objc func timeManager()  {
        if(secondsPassed < totalTime){
            progressBar.progress += Float((1/totalTime))
            secondsPassed += 1
            
            if(secondsPassed == totalTime){
                progressBar.progress = 1.0
                
                timer.invalidate()
                player.play()
                
                self.textLabel.text = "Done!!!"
                
                Timer.scheduledTimer(withTimeInterval: 4.18, repeats: false) { (timer) in
                    self.textLabel.text = "How Do You Like Your Eggs?"
                    timer.invalidate()
                }
            }
        }
    }
    
}

