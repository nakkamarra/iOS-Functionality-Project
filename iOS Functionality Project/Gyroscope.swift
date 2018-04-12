//
//  Gyroscope.swift
//  iOS Functionality Project
//
//  Created by Nicholas Brandt on 4/11/18.
//  Copyright © 2018 Nicholas Brandt. All rights reserved.
//

import UIKit
import CoreMotion

class Gyroscope : UIViewController {
    
    let xLabel = UILabel()
    let yLabel = UILabel()
    let zLabel = UILabel()
    let trigger = UIButton(type: .roundedRect)
    var floater = UIView()
    let motionManager = CMMotionManager()
    let gyroReadRate = 1.0 / 15.0
    var timer : Timer?
    var gyroCurrentlyActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        let click = UITapGestureRecognizer(target: self, action: #selector(triggerClicked))
        trigger.addGestureRecognizer(click)
    }
    
    //Handle button click events
    @objc private func triggerClicked(){
        if gyroCurrentlyActive{
            stopGyros()
            trigger.setTitle("Start Gyro", for: .normal)
            trigger.isSelected = false
        } else {
            startGyros()
            trigger.setTitle("Stop Gyro", for: .normal)
            trigger.isSelected = true
        }
    }
    
    //Begin reading gyroscopic input
    func startGyros() {
        gyroCurrentlyActive = true
        motionManager.gyroUpdateInterval = gyroReadRate
        motionManager.startGyroUpdates()
        
        timer = Timer(fire: Date(), interval: gyroReadRate, repeats: true, block: { (timer) in
            if let data = self.motionManager.gyroData {
                self.xLabel.text = "X Axis: " + String(data.rotationRate.x)
                self.yLabel.text = "Y Axis: " + String(data.rotationRate.y)
                self.zLabel.text = "Z Axis: " + String(data.rotationRate.z)
                
                UIView.animate(withDuration: 0.75, animations: {
                    self.floater.transform = CGAffineTransform(translationX: -30 * CGFloat(data.rotationRate.y), y: -30 * CGFloat(data.rotationRate.x))
                })
            }
        })
        
        RunLoop.current.add(timer!, forMode: .defaultRunLoopMode)
    }
    
    //Stop reading gryoscopic input
    func stopGyros() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
            
            motionManager.stopGyroUpdates()
            gyroCurrentlyActive = false
        }
    }
}

private extension Gyroscope {
    
    // Setup the UI elements using AutoLayout
    func setup() {
        view.addSubview(xLabel)
        xLabel.translatesAutoresizingMaskIntoConstraints = false
        xLabel.text = "X Axis: "
        xLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        view.addSubview(yLabel)
        yLabel.translatesAutoresizingMaskIntoConstraints = false
        yLabel.text = "Y Axis: "
        yLabel.topAnchor.constraint(equalTo: xLabel.bottomAnchor).isActive = true
        
        view.addSubview(zLabel)
        zLabel.translatesAutoresizingMaskIntoConstraints = false
        zLabel.text = "Z Axis: "
        zLabel.topAnchor.constraint(equalTo: yLabel.bottomAnchor).isActive = true
        
        view.addSubview(trigger)
        trigger.translatesAutoresizingMaskIntoConstraints = false
        trigger.setTitle("Start Gyro", for: .normal)
        trigger.topAnchor.constraint(equalTo: zLabel.bottomAnchor).isActive = true
        
        floater = UIView(frame: CGRect(x: view.frame.midX - 70, y: view.frame.midY - 40, width: 140, height: 80))
        view.addSubview(floater)
        floater.translatesAutoresizingMaskIntoConstraints = false
        floater.backgroundColor = .green
    }
}
