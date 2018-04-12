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
        memoryLabel.text = "MEM: " + String(task_basic_info().resident_size)
    }
    
    @objc func reportCpu() {
        cpuLabel.text = "CPU: " + String(task_basic_info().policy)
    }
    
    override func layoutSubviews() {
        memoryLabel.translatesAutoresizingMaskIntoConstraints = false
        memoryLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        memoryLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        
        cpuLabel.translatesAutoresizingMaskIntoConstraints = false
        cpuLabel.topAnchor.constraint(equalTo: memoryLabel.bottomAnchor).isActive = true
        memoryLabel.leftAnchor.constraint(equalTo: memoryLabel.leftAnchor).isActive = true
    }
}
