//
//  LogMyRunUITests.swift
//  LogMyRunUITests
//

import XCTest

class LogMyRunUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        //XCUIApplication().launch()
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        app.terminate()
    }
    
    func viewDidLoad() {
        //super.viewDidLoad()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testElementExists() {
        XCTAssert(app.buttons["START"].exists)
    }
    
    func testStartActionBeginsTracking()
    {
        app.buttons["START"].tap();
        
     
    }

    /*
    func testStopActionEndsTracking()
    {
        app.buttons["START"].tap();
        app.buttons["STOP"].tap();
    }
    */
    func testSaveActionSavesRun() {
        app.buttons["START"].tap();

        app.buttons["STOP"].tap();
        
        app.alerts["Run Stopped"].buttons["Save"].tap()
        
    }
    
}
