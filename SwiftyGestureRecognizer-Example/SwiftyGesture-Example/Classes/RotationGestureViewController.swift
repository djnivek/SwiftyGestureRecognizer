//
//  RotationGestureViewController.swift
//  SwiftyGesture-Example
//
//  Created by Kévin MACHADO on 26/10/2018.
//  Copyright © 2018 Kévin MACHADO. All rights reserved.
//

import UIKit
import SwiftyGestureRecognizer

class RotationGestureViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GestureRecognizer(for: imageView).rotated { (imageView, gesture) in
            print("rotation")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        GestureRecognizer.uninstall(imageView)
    }

}
