//
//  PinchGestureViewController.swift
//  SwiftyGesture-Example
//
//  Created by Kévin MACHADO on 30/10/2018.
//  Copyright © 2018 Kévin MACHADO. All rights reserved.
//

import UIKit
import SwiftyGestureRecognizer

class PinchGestureViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        GestureRecognizer.get(imageView).pinched { (imageView, gesture) in
            print("panned")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        GestureRecognizer.uninstall(imageView)
    }

}
