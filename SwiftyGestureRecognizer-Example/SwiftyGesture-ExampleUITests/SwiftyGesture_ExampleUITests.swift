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
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTapHandled() {
        
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Tap"]/*[[".cells.staticTexts[\"Tap\"]",".staticTexts[\"Tap\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let labelStaticText = app.staticTexts["Label"]
        labelStaticText.tap()
        
        XCTAssert(labelStaticText.label == "Tapped")
    }
    
}
