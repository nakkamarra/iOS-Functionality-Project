//
//  HapticFeedback.swift
//  iOS Functionality Project
//
//  Created by Nicholas Brandt on 4/11/18.
//  Copyright © 2018 Nicholas Brandt. All rights reserved.
//

import UIKit

class HapticFeedback : UIViewController {
    
    let lightHaptics = UIImpactFeedbackGenerator(style: .light)
    let medHaptics = UIImpactFeedbackGenerator(style: .medium)
    let heavyHaptics = UIImpactFeedbackGenerator(style: .heavy)
    let lightButton = UIButton(type: .roundedRect)
    let medButton = UIButton(type: .roundedRect)
    let heavyButton = UIButton(type: .roundedRect)
    let redView = UIView()
    let blueView = UIView()
    var lightGR = UITapGestureRecognizer()
    var medGR = UITapGestureRecognizer()
    var heavyGR = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        lightGR = UITapGestureRecognizer(target: self, action: #selector(simulateCollision(sender:)))
        medGR = UITapGestureRecognizer(target: self, action: #selector(simulateCollision(sender:)))
        heavyGR = UITapGestureRecognizer(target: self, action: #selector(simulateCollision(sender:)))
        
        lightButton.addGestureRecognizer(lightGR)
        medButton.addGestureRecognizer(medGR)
        heavyButton.addGestureRecognizer(heavyGR)
    }
    
    @objc private func simulateCollision(sender: UITapGestureRecognizer) {
        var offset: CGFloat
        var haptic: UIImpactFeedbackGenerator
        var animationSpeed: TimeInterval
        
        if sender === lightGR {
            offset = 2
            haptic = lightHaptics
            animationSpeed = 0.65
        } else if sender === medGR {
            offset = 4
            haptic = medHaptics
            animationSpeed = 0.25
        } else {
            offset = 8
            haptic = heavyHaptics
            animationSpeed = 0.1
        }
        
        UIView.animate(withDuration: animationSpeed, animations: {
            let viewWidth = self.redView.frame.width - offset
            let widthDistance = self.view.safeAreaLayoutGuide.layoutFrame.width / 2 - viewWidth
            self.redView.transform = CGAffineTransform(translationX: widthDistance, y: 0)
            self.blueView.transform = CGAffineTransform(translationX: -widthDistance, y: 0)
        }) { (completed) in
            haptic.impactOccurred()
            self.returnToStart()
        }
    }
    
    private func returnToStart() {
        UIView.animate(withDuration: 1.0) {
            self.redView.transform = CGAffineTransform.identity
            self.blueView.transform = CGAffineTransform.identity
        }
    }
}

private extension HapticFeedback{
    
    func setup() {
        view.addSubview(lightButton)
        lightButton.translatesAutoresizingMaskIntoConstraints = false
        lightButton.setTitle("Light Collision", for: .normal)
        lightButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        lightButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(medButton)
        medButton.translatesAutoresizingMaskIntoConstraints = false
        medButton.setTitle("Medium Collision", for: .normal)
        medButton.topAnchor.constraint(equalTo: lightButton.bottomAnchor, constant: 8).isActive = true
        medButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(heavyButton)
        heavyButton.translatesAutoresizingMaskIntoConstraints = false
        heavyButton.setTitle("Heavy Collision", for: .normal)
        heavyButton.topAnchor.constraint(equalTo: medButton.bottomAnchor, constant: 8).isActive = true
        heavyButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        view.addSubview(redView)
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = .red
        redView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        redView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        redView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.15).isActive = true
        redView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.25).isActive = true
        
        view.addSubview(blueView)
        blueView.translatesAutoresizingMaskIntoConstraints = false
        blueView.backgroundColor = .blue
        blueView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        blueView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        blueView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.15).isActive = true
        blueView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.25).isActive = true
        
        let systemView = SystemView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.addSubview(systemView)
        systemView.translatesAutoresizingMaskIntoConstraints = false
        systemView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        systemView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.85).isActive = true
        systemView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        systemView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
    }
    
}

