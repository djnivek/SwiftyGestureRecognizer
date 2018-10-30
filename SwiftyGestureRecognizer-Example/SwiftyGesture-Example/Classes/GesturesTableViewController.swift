//
//  ViewController.swift
//  SwiftyGesture-Example
//
//  Created by Kévin MACHADO on 09/04/2018.
//  Copyright © 2018 Kévin MACHADO. All rights reserved.
//

import UIKit

struct Gesture {
    var title: String
    var segueName: String
}

struct Gestures {
    static let pinch = Gesture(title: "Pinch", segueName: "PinchSegue")
    static let rotate = Gesture(title: "Rotate", segueName: "RotationSegue")
    static let drag = Gesture(title: "Drag", segueName: "PanSegue")
    static let tap = Gesture(title: "Tap", segueName: "TapSegue")
}

class GesturesTableViewController: UITableViewController {
    
    let CellIdentifier = "Cell"

    var gestures: [Gesture] = [
        Gestures.pinch,
        Gestures.rotate,
        Gestures.drag,
        Gestures.tap,
    ]
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // navigate to appropriated controller
        let segueName = gestures[indexPath.row].segueName
        self.performSegue(withIdentifier: segueName, sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: CellIdentifier)
        }
        cell.textLabel?.text = gestures[indexPath.row].title
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gestures.count
    }

}

