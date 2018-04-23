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
        // get the current task's info
        var taskInfo = mach_task_basic_info()
        // count the current task's number of pages
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        // fetch the portion of the task's memory that is in use
        let kernelFetch: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }
        // If memory fetch is a failure, exit method call without updating label
        guard kernelFetch == KERN_SUCCESS else { return }
        // Update label
        let currentMem = taskInfo.resident_size
        memoryLabel.text = "MEM: Using \(currentMem) bytes"
    }
    
    @objc func reportCpu() {
        var kernelReturn: kern_return_t
        var task_info_count: mach_msg_type_number_t
        
        task_info_count = mach_msg_type_number_t(TASK_INFO_MAX)
        var tinfo = [integer_t](repeating: 0, count: Int(task_info_count))
        
        kernelReturn = task_info(mach_task_self_, task_flavor_t(TASK_BASIC_INFO), &tinfo, &task_info_count)
        if kernelReturn != KERN_SUCCESS { return }
        
        var thread_list: thread_act_array_t? = UnsafeMutablePointer(mutating: [thread_act_t]())
        var thread_count: mach_msg_type_number_t = 0
        defer {
            if let thread_list = thread_list {
                vm_deallocate(mach_task_self_, vm_address_t(UnsafePointer(thread_list).pointee), vm_size_t(thread_count))
            }
        }
        
        kernelReturn = task_threads(mach_task_self_, &thread_list, &thread_count)
        // If the kernel fetch fails, exit form the method call
        if kernelReturn != KERN_SUCCESS { return }
        
        var total_cpu: Double = 0
        // calculate total_cpu for every thread
        if let thread_list = thread_list {
            // get thread info for every thread
            for j in 0 ..< Int(thread_count) {
                var thread_info_count = mach_msg_type_number_t(THREAD_INFO_MAX)
                var thinfo = [integer_t](repeating: 0, count: Int(thread_info_count))
                kernelReturn = thread_info(thread_list[j], thread_flavor_t(THREAD_BASIC_INFO),
                                 &thinfo, &thread_info_count)
                if kernelReturn != KERN_SUCCESS { return }
                let threadBasicInfo = convertThreadInfoToThreadBasicInfo(thinfo)
                if threadBasicInfo.flags != TH_FLAGS_IDLE {
                    total_cpu += (Double(threadBasicInfo.cpu_usage) / Double(TH_USAGE_SCALE)) * 100.0
                }
            }
        }
        
        //Update label
        cpuLabel.text = "CPU: Using " + String(describing: total_cpu) + "%"
    }
    
    // Convert the array of thread properties to a thread_basic_info object
    func convertThreadInfoToThreadBasicInfo(_ threadInfo: [integer_t]) -> thread_basic_info {
        var result = thread_basic_info()
        
        result.user_time = time_value_t(seconds: threadInfo[0], microseconds: threadInfo[1])
        result.system_time = time_value_t(seconds: threadInfo[2], microseconds: threadInfo[3])
        result.cpu_usage = threadInfo[4]
        result.policy = threadInfo[5]
        result.run_state = threadInfo[6]
        result.flags = threadInfo[7]
        result.suspend_count = threadInfo[8]
        result.sleep_time = threadInfo[9]
        
        return result
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
