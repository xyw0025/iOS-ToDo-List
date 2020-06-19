//
//  PomodoroController.swift
//  ToDoList
//
//  Created by tina on 2020/6/18.
//  Copyright © 2020 tina. All rights reserved.
//

import Foundation
import UIKit

class PomodoroController: UIViewController {
    
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var timer = Timer()
    var isTimerStarted = false
    var time = 7    //2500
    var isBreakMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "#E68552")
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        if !isTimerStarted{
            startTimer()
            isTimerStarted = true
            startButton.setTitle("Pause", for: .normal)
        }else {
            timer.invalidate()
            isTimerStarted = false
            startButton.setTitle("Resume", for: .normal)
        }
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        timer.invalidate()
        isTimerStarted = false
        switchMode(mode: isBreakMode)
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        time -= 1
        timeLabel.text = formatTime()
        if time == 0 {
            timer.invalidate()
            isTimerStarted = false
            startButton.setTitle("Start", for: .normal)
            switchMode(mode: isBreakMode)
        }
    }
    
    func formatTime() -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    func switchMode(mode: Bool) {
        if !isBreakMode {
            time = 3    //300
            timeLabel.text = "05:00"
            modeLabel.text = "Break Mode"
            self.view.backgroundColor = UIColor(hex: "#6C9460")
            isBreakMode = true
        } else {
            time = 5    //1500
            timeLabel.text = "25:00"
            modeLabel.text = "Work Mode"
            self.view.backgroundColor = UIColor(hex: "#E68552")
            isBreakMode = false
        }
    }
}
