//
//  SwiftyGesture_ExampleUITests.swift
//  SwiftyGesture-ExampleUITests
//
//  Created by Kévin MACHADO on 09/04/2018.
//  Copyright © 2018 Kévin MACHADO. All rights reserved.
//

import XCTest

class SwiftyGesture_ExampleUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
//    func testTapHandled() {
//        
//        let app = XCUIApplication()
//        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Tap"]/*[[".cells.staticTexts[\"Tap\"]",".staticTexts[\"Tap\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        
//        let labelStaticText = app.staticTexts["Label"]
//        labelStaticText.tap()
//        
//        XCTAssert(labelStaticText.label == "Tapped")
//    }
    
}
