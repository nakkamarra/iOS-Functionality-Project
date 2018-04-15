//
//  Barometer.swift
//  iOS Functionality Project
//
//  Created by Nicholas Brandt on 4/11/18.
//  Copyright © 2018 Nicholas Brandt. All rights reserved.
//

import UIKit
import CoreMotion

class Barometer : UIViewController {
    
    let pressureLabel = UILabel()
    let altitudeLabel = UILabel()
    let trigger = UIButton(type: .roundedRect)
    let altimeter = CMAltimeter()
    var altimeterIsActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(triggerClicked))
        trigger.addGestureRecognizer(tapGR)
    }
    
    @objc private func triggerClicked() {
        if !altimeterIsActive {
            if CMAltimeter.isRelativeAltitudeAvailable() {
                startAltimeter()
                trigger.isSelected = true
                trigger.setTitle("Stop Altimeter", for: .normal)
            }
        } else {
            stopAltimeter()
            trigger.isSelected = false
            trigger.setTitle("Start Altimeter", for: .normal)
        }
    }
    
    private func startAltimeter() {
        altimeter.startRelativeAltitudeUpdates(to: OperationQueue.current!) { (altimeterOutput, error) in
            if let data = altimeterOutput {
                self.pressureLabel.text = "Pressure: " + String(describing: data.pressure) + " kPa"
                self.altitudeLabel.text = "Alt. Change: " + String(describing: data.relativeAltitude) + " m"
            }
        }
        altimeterIsActive = true
    }
    
    private func stopAltimeter() {
        altimeter.stopRelativeAltitudeUpdates()
        altimeterIsActive = false
    }
}

private extension Barometer {
    
    func setup() {
        view.addSubview(pressureLabel)
        pressureLabel.translatesAutoresizingMaskIntoConstraints = false
        pressureLabel.text = "Pressure: "
        pressureLabel.textAlignment = .center
        pressureLabel.font = UIFont(name: "Avenir Next", size: 20)
        pressureLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        pressureLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(altitudeLabel)
        altitudeLabel.translatesAutoresizingMaskIntoConstraints = false
        altitudeLabel.text = "Alt. Change: "
        altitudeLabel.textAlignment = .center
        altitudeLabel.font = UIFont(name: "Avenir Next", size: 20)
        altitudeLabel.topAnchor.constraint(equalTo: pressureLabel.bottomAnchor, constant: 20).isActive = true
        altitudeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(trigger)
        trigger.translatesAutoresizingMaskIntoConstraints = false
        trigger.setTitle("Start Altimeter", for: .normal)
        trigger.topAnchor.constraint(equalTo: altitudeLabel.bottomAnchor, constant: 20).isActive = true
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

