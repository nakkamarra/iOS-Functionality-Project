//
//  Accelerometer.swift
//  iOS Functionality Project
//
//  Created by Nicholas Brandt on 4/11/18.
//  Copyright © 2018 Nicholas Brandt. All rights reserved.
//

import UIKit
import CoreMotion

class Accelerometer : UIViewController {
    
    let xLabel = UILabel()
    let yLabel = UILabel()
    let zLabel = UILabel()
    let trigger = UIButton(type: .roundedRect)
    let motionManager = CMMotionManager()
    let accelerometerReadRate = 1.0 / 10.0 //10Hz
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        let click = UITapGestureRecognizer(target: self, action: #selector(triggerClicked))
        trigger.addGestureRecognizer(click)
    }
    
    @objc private func triggerClicked() {
        if motionManager.isAccelerometerActive {
            stopAccelerometer()
            trigger.setTitle("Start Accelerometer", for: .normal)
            trigger.isSelected = false
        } else {
            startAccelerometer()
            trigger.setTitle("Stop Accelerometer", for: .normal)
            trigger.isSelected = true
        }
    }
    
    func startAccelerometer() {
        motionManager.accelerometerUpdateInterval = accelerometerReadRate
        motionManager.startAccelerometerUpdates()
        
        timer = Timer(fire: Date(), interval: accelerometerReadRate, repeats: true, block: { (timer) in
            if let data = self.motionManager.accelerometerData {
                self.xLabel.text = "X Velocity: " + String(data.acceleration.x * 9.8) + "m/s"
                self.yLabel.text = "Y Velocity: " + String(data.acceleration.y * 9.8) + "m/s"
                self.zLabel.text = "Z Velocity: " + String(data.acceleration.z * 9.8) + "m/s"
            }
        })
        
        RunLoop.current.add(timer!, forMode: .defaultRunLoopMode)
    }
    
    func stopAccelerometer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
            
            motionManager.stopAccelerometerUpdates()
        }
    }
}

private extension Accelerometer {
    
    func setup() {
        view.addSubview(xLabel)
        xLabel.translatesAutoresizingMaskIntoConstraints = false
        xLabel.text = "X Velocity: "
        xLabel.textAlignment = .center
        xLabel.font = UIFont(name: "Avenir Next", size: 20)
        xLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        xLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(yLabel)
        yLabel.translatesAutoresizingMaskIntoConstraints = false
        yLabel.text = "Y Velocity: "
        yLabel.textAlignment = .center
        yLabel.font = UIFont(name: "Avenir Next", size: 20)
        yLabel.topAnchor.constraint(equalTo: xLabel.bottomAnchor, constant: 20).isActive = true
        yLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(zLabel)
        zLabel.translatesAutoresizingMaskIntoConstraints = false
        zLabel.text = "Z Velocity: "
        zLabel.textAlignment = .center
        zLabel.font = UIFont(name: "Avenir Next", size: 20)
        zLabel.topAnchor.constraint(equalTo: yLabel.bottomAnchor, constant: 20).isActive = true
        zLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(trigger)
        trigger.translatesAutoresizingMaskIntoConstraints = false
        trigger.setTitle("Start Accelerometer", for: .normal)
        trigger.topAnchor.constraint(equalTo: zLabel.bottomAnchor, constant: 20).isActive = true
        trigger.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        let systemView = SystemView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.addSubview(systemView)
        systemView.translatesAutoresizingMaskIntoConstraints = false
        systemView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        systemView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.85).isActive = true
        systemView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        systemView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
    }
    
}
