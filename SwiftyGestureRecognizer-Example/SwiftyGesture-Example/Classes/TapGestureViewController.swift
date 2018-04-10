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
        
        GestureRecognizer.install(label).pressed { (label, gesture) in
            label.textColor = label.textColor == .red ? .green : .red
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        GestureRecognizer.uninstall(label)
    }

}
