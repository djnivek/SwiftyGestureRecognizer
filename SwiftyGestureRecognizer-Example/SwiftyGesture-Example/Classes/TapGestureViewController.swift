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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        label.isUserInteractionEnabled = true
        GestureRecognizer(for: label).pressed { (label, _) in
            label.textColor = label.textColor == .red ? .green : .red
            label.text = "Tapped"
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        GestureRecognizer.uninstall(label)
    }

}
