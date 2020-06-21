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
    var isReStart = false
    var time = 20    //2500
    var isBreakMode = false
    let shapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modeLabel.textColor = UIColor.LightModeColor.textColor
        timeLabel.textColor = UIColor.LightModeColor.textColor
        startButton.setTitleColor(UIColor.LightModeColor.textColor, for: .normal)
        cancelButton.setTitleColor(UIColor.LightModeColor.textColor, for: .normal)
        
        let center = view.center
        let trackLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: center, radius: 130, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circlePath.cgPath
        trackLayer.strokeColor = UIColor.LightModeColor.trackLayerColor.cgColor
        trackLayer.lineWidth = 2
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        view.layer.addSublayer(trackLayer)

        let aDegree = CGFloat.pi / 180
        let startDegree: CGFloat = 270
        let shapeLayerEndAngle: CGFloat = aDegree * (startDegree + 360)
        let shapeLayerPath = UIBezierPath(arcCenter: center, radius: 130, startAngle: aDegree * startDegree, endAngle: shapeLayerEndAngle, clockwise: true)
        
        shapeLayer.path = shapeLayerPath.cgPath
        shapeLayer.lineWidth = 20
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.LightModeColor.shapeLayerWorkColor.cgColor
        shapeLayer.strokeEnd = 0
        view.layer.addSublayer(shapeLayer)
    }
    
    func drawProgressBar() {
        print("tap")
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = CFTimeInterval(time)
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: nil)
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        if !isReStart {
            drawProgressBar()
            isReStart = true
        }
        if !isTimerStarted{
            resumeLayer(layer: shapeLayer)
            startTimer()
            isTimerStarted = true
            startButton.setTitle("Pause", for: .normal)
        }else {
            pauseLayer(layer: shapeLayer)
            timer.invalidate()
            isTimerStarted = false
            startButton.setTitle("Resume", for: .normal)
        }
    }
    
    func pauseLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }

    func resumeLayer(layer: CALayer) {
        let pausedTime: CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        isReStart = false
        shapeLayer.removeAllAnimations()
        timer.invalidate()
        isTimerStarted = false
        switchMode(mode: isBreakMode)
        startButton.setTitle("Start", for: .normal)
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        time -= 1
        timeLabel.text = formatTime()
        if time == 0 {
            isReStart = false
            shapeLayer.removeAllAnimations()
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
            shapeLayer.strokeColor = UIColor.LightModeColor.shapeLayerBreakColor.cgColor
            isBreakMode = true
        } else {
            time = 5    //1500
            timeLabel.text = "25:00"
            modeLabel.text = "Work Mode"
            shapeLayer.strokeColor = UIColor.LightModeColor.shapeLayerWorkColor.cgColor
            isBreakMode = false
        }
    }
}
