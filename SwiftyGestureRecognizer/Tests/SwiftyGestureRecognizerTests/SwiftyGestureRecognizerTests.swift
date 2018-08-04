//
//  SwiftyGestureRecognizerTests.swift
//  SwiftyGestureRecognizer
//
//  Created by Kevin MACHADO on 29/03/2018.
//  Copyright © 2018 SwiftyGestureRecognizer. All rights reserved.
//

import UIKit
import XCTest
import SwiftyGestureRecognizer

class SwiftyGestureRecognizerTests: XCTestCase {
    
    func testAllocation() {
        let label = UILabel()
        GestureRecognizer.install(label).pressed { (_, _) in }
        let gesture = GestureRecognizer._debugGet(for: label)
        let tapGesture = gesture.gestureRecognizer
        XCTAssertNotNil(tapGesture, "UIGestureRecognizer not instantiated")
    }
    
    static var allTests = [
        ("testAllocation", testAllocation),
    ]
}
