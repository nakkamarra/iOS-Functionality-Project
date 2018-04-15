//
//  ViewController.swift
//  iOS Functionality Project
//
//  Created by Nicholas Brandt on 4/11/18.
//  Copyright © 2018 Nicholas Brandt. All rights reserved.
//

import UIKit

class MainDirectory: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let instructions = UILabel()
    let featuresTable = UITableView()
    let features = ["Gyroscope Demo", "Haptic Feedback Demo", "Barometer Demo", "Accelerometer Demo", "Magnetometer Demo"]
    let reuseID = "CellID"

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        featuresTable.delegate = self
        featuresTable.dataSource = self
        featuresTable.register(UITableViewCell.self, forCellReuseIdentifier: reuseID)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        switch (cell.textLabel?.text){
            case features[0]?:
                self.navigationController?.pushViewController(Gyroscope(), animated: true)
                break
            case features[1]?:
                self.navigationController?.pushViewController(HapticFeedback(), animated: true)
                break
            case features[2]?:
                self.navigationController?.pushViewController(Barometer(), animated: true)
                break
            case features[3]?:
                self.navigationController?.pushViewController(Accelerometer(), animated: true)
                break
            case features[4]?:
                self.navigationController?.pushViewController(Magnetometer(), animated: true)
                break
            default:
                break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        cell.textLabel?.text = features[indexPath[1]]
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return features.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

private extension MainDirectory {
    func setup() {
        view.addSubview(featuresTable)
        featuresTable.translatesAutoresizingMaskIntoConstraints = false
        featuresTable.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        featuresTable.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        featuresTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
}
