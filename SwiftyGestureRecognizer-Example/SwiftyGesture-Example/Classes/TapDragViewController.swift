//
//  TapDragViewController.swift
//  SwiftyGesture-Example
//
//  Created by Kévin MACHADO on 07/11/2018.
//  Copyright © 2018 Kévin MACHADO. All rights reserved.
//

import UIKit
import SwiftyGestureRecognizer

class TapDragViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GestureRecognizer.get(imageView).pannable().pressed { (imageView, _) in
            self.imageView.backgroundColor = self.imageView.backgroundColor == .gray ? .red : .gray
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        GestureRecognizer.uninstall(imageView)
    }

}
