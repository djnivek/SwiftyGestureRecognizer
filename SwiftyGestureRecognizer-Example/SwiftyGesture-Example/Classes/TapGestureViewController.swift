//
//  TapGestureViewController.swift
//  SwiftyGesture-Example
//
//  Created by Kévin MACHADO on 10/04/2018.
//  Copyright © 2018 Kévin MACHADO. All rights reserved.
//

import UIKit
import SwiftyGestureRecognizer

class TapGestureViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        label.isUserInteractionEnabled = true
        GestureRecognizer.install(label).pressed { (label, gesture) in
            label.textColor = label.textColor == .red ? .green : .red
            label.text = "Tapped"
        }
        
        let gestureMananger = GestureRecognizer._debugGet(for: label)
        let tapGesture = gestureMananger.gestureRecognizer
        print("TapGesture \(tapGesture == nil)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        GestureRecognizer.uninstall(label)
    }
    
    @objc func action() {
        print("test action on press")
    }

}
