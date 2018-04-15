//
//  Magnetometer.swift
//  iOS Functionality Project
//
//  Created by Nicholas Brandt on 4/14/18.
//  Copyright © 2018 Nicholas Brandt. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation

class Magnetometer: UIViewController {
    
    let xLabel = UILabel()
    let yLabel = UILabel()
    let zLabel = UILabel()
    let trigger = UIButton(type: .roundedRect)
    let magneticLabel = UILabel()
    let geographicLabel = UILabel()
    let locationManager = CLLocationManager()
    let motionManager = CMMotionManager()
    let magnetometerReadRate = 1.0 / 15.0 //15Hz
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        let click = UITapGestureRecognizer(target: self, action: #selector(triggerClicked))
        trigger.addGestureRecognizer(click)
    }
    
    @objc private func triggerClicked() {
        if motionManager.isMagnetometerActive {
            stopMagnetometer()
            trigger.setTitle("Start Magnetometer", for: .normal)
            trigger.isSelected = false
        } else {
            startMagnetometer()
            trigger.setTitle("Stop Magnetometer", for: .normal)
            trigger.isSelected = true
        }
    }
    
    func startMagnetometer() {
        motionManager.magnetometerUpdateInterval = magnetometerReadRate
        motionManager.startMagnetometerUpdates()
        locationManager.startUpdatingHeading()
        
        timer = Timer(fire: Date(), interval: magnetometerReadRate, repeats: true, block: { (timer) in
            if let data = self.motionManager.magnetometerData {
                self.xLabel.text = "X Axis: " + String(data.magneticField.x) + " mT"
                self.yLabel.text = "Y Axis: " + String(data.magneticField.y) + " mT"
                self.zLabel.text = "Z Axis: " + String(data.magneticField.z) + " mT"
            }
            
            if let magneticDegree = self.locationManager.heading?.magneticHeading {
                var directionString = ""
                if magneticDegree > 315 || magneticDegree < 45 {
                    directionString = "North"
                } else if magneticDegree > 225 {
                    directionString = "West"
                } else if magneticDegree > 135 {
                    directionString = "South"
                } else if magneticDegree > 45 {
                    directionString = "East"
                }
                self.magneticLabel.text = "Magnetic: " + directionString
            }
            
            if let geographicDegree = self.locationManager.heading?.trueHeading {
                var directionString = ""
                if geographicDegree > 315 || geographicDegree < 45 {
                    directionString = "North"
                } else if geographicDegree > 225 {
                    directionString = "West"
                } else if geographicDegree > 135 {
                    directionString = "South"
                } else if geographicDegree > 45 {
                    directionString = "East"
                }
                self.geographicLabel.text = "Geographic: " + directionString
            }
        })
        
        RunLoop.current.add(timer!, forMode: .defaultRunLoopMode)
    }
    
    func stopMagnetometer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
            
            motionManager.stopMagnetometerUpdates()
            locationManager.stopUpdatingHeading()
        }
    }
}

private extension Magnetometer {
    
    func setup() {
        view.addSubview(xLabel)
        xLabel.translatesAutoresizingMaskIntoConstraints = false
        xLabel.text = "X Axis: "
        xLabel.textAlignment = .center
        xLabel.font = UIFont(name: "Avenir Next", size: 20)
        xLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        xLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(yLabel)
        yLabel.translatesAutoresizingMaskIntoConstraints = false
        yLabel.text = "Y Axis: "
        yLabel.textAlignment = .center
        yLabel.font = UIFont(name: "Avenir Next", size: 20)
        yLabel.topAnchor.constraint(equalTo: xLabel.bottomAnchor, constant: 20).isActive = true
        yLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(zLabel)
        zLabel.translatesAutoresizingMaskIntoConstraints = false
        zLabel.text = "Z Axis: "
        zLabel.textAlignment = .center
        zLabel.font = UIFont(name: "Avenir Next", size: 20)
        zLabel.topAnchor.constraint(equalTo: yLabel.bottomAnchor, constant: 20).isActive = true
        zLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(trigger)
        trigger.translatesAutoresizingMaskIntoConstraints = false
        trigger.setTitle("Start Magnetometer", for: .normal)
        trigger.topAnchor.constraint(equalTo: zLabel.bottomAnchor, constant: 20).isActive = true
        trigger.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(magneticLabel)
        magneticLabel.translatesAutoresizingMaskIntoConstraints = false
        magneticLabel.text = "Magnetic: "
        magneticLabel.textAlignment = .center
        magneticLabel.font = UIFont(name: "Avenir Next", size: 32)
        magneticLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        magneticLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(geographicLabel)
        geographicLabel.translatesAutoresizingMaskIntoConstraints = false
        geographicLabel.text = "Geographic: "
        geographicLabel.textAlignment = .center
        geographicLabel.font = UIFont(name: "Avenir Next", size: 32)
        geographicLabel.topAnchor.constraint(equalTo: magneticLabel.bottomAnchor).isActive = true
        geographicLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        let systemView = SystemView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.addSubview(systemView)
        systemView.translatesAutoresizingMaskIntoConstraints = false
        systemView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        systemView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.85).isActive = true
        systemView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        systemView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
    }
    
}
