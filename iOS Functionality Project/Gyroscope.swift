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
    let gyroReadRate = 1.0 / 15.0 //15Hz
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        let click = UITapGestureRecognizer(target: self, action: #selector(triggerClicked))
        trigger.addGestureRecognizer(click)
    }
    
    //Handle button click events
    @objc private func triggerClicked(){
        if motionManager.isGyroActive {
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
    private func startGyros() {
        motionManager.gyroUpdateInterval = gyroReadRate
        motionManager.startGyroUpdates()
        
        timer = Timer(fire: Date(), interval: gyroReadRate, repeats: true, block: { (timer) in
            if let data = self.motionManager.gyroData {
                self.xLabel.text = "X Rotation: " + String(data.rotationRate.x)
                self.yLabel.text = "Y Rotation: " + String(data.rotationRate.y)
                self.zLabel.text = "Z Rotation: " + String(data.rotationRate.z)
                
                UIView.animate(withDuration: 0.75, animations: {
                    self.floater.transform = CGAffineTransform(translationX: -30 * CGFloat(data.rotationRate.y), y: -30 * CGFloat(data.rotationRate.x))
                })
            }
        })
        
        RunLoop.current.add(timer!, forMode: .defaultRunLoopMode)
    }
    
    //Stop reading gryoscopic input
    private func stopGyros() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
            
            motionManager.stopGyroUpdates()
        }
    }
}

private extension Gyroscope {
    
    // Setup the UI elements using AutoLayout
    func setup() {
        view.addSubview(xLabel)
        xLabel.translatesAutoresizingMaskIntoConstraints = false
        xLabel.text = "X Rotation: "
        xLabel.textAlignment = .center
        xLabel.font = UIFont(name: "Avenir Next", size: 20)
        xLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        xLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(yLabel)
        yLabel.translatesAutoresizingMaskIntoConstraints = false
        yLabel.text = "Y Rotation: "
        yLabel.textAlignment = .center
        yLabel.font = UIFont(name: "Avenir Next", size: 20)
        yLabel.topAnchor.constraint(equalTo: xLabel.bottomAnchor, constant: 8).isActive = true
        yLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(zLabel)
        zLabel.translatesAutoresizingMaskIntoConstraints = false
        zLabel.text = "Z Rotation: "
        zLabel.textAlignment = .center
        zLabel.font = UIFont(name: "Avenir Next", size: 20)
        zLabel.topAnchor.constraint(equalTo: yLabel.bottomAnchor, constant: 8).isActive = true
        zLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(trigger)
        trigger.translatesAutoresizingMaskIntoConstraints = false
        trigger.setTitle("Start Gyro", for: .normal)
        trigger.topAnchor.constraint(equalTo: zLabel.bottomAnchor, constant: 8).isActive = true
        trigger.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        floater = UIView(frame: CGRect(x: view.frame.midX - 70, y: view.frame.midY - 40, width: 140, height: 80))
        view.addSubview(floater)
        floater.translatesAutoresizingMaskIntoConstraints = false
        floater.backgroundColor = .green
        
        let systemView = SystemView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.addSubview(systemView)
        systemView.translatesAutoresizingMaskIntoConstraints = false
        systemView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        systemView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.85).isActive = true
        systemView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        systemView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
    }
}
