//
//  SystemView.swift
//  iOS Functionality Project
//
//  Created by Nicholas Brandt on 4/12/18.
//  Copyright © 2018 Nicholas Brandt. All rights reserved.
//

import UIKit

class SystemView : UIView {
    
    let memoryLabel = UILabel()
    let cpuLabel = UILabel()
    let task = task_basic_info()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(memoryLabel)
        self.addSubview(cpuLabel)
        beginReading()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginReading() {
        Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true) { (_) in
            self.reportMemory()
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true) { (_) in
            self.reportCpu()
        }
    }
    
    @objc func reportMemory() {
        memoryLabel.text = "MEM: Using " + String(describing: task.resident_size) + " bytes"
    }
    
    @objc func reportCpu() {
        cpuLabel.text = "CPU: Using " + String(describing: task.virtual_size) + " percent"
    }
    
    override func layoutSubviews() {
        memoryLabel.translatesAutoresizingMaskIntoConstraints = false
        memoryLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        memoryLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        memoryLabel.font = UIFont(name: "Avenir Next", size: 20)
        memoryLabel.numberOfLines = 0
        
        cpuLabel.translatesAutoresizingMaskIntoConstraints = false
        cpuLabel.topAnchor.constraint(equalTo: memoryLabel.bottomAnchor).isActive = true
        cpuLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        cpuLabel.font = UIFont(name: "Avenir Next", size: 20)
        cpuLabel.numberOfLines = 0
    }
}
