import XCTest
import Szimpla

class AppUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDefault() {
        try! SzimplaClient.instance.start()
        let app = XCUIApplication()
        sleep(1)
        app.buttons["Navigate"].tap()
        app.navigationBars["App.SecondView"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        XCTAssert(app.buttons["Navigate"].exists, "It couldn't navigate")
        try! SzimplaClient.instance.record(path: "CMDUConf.json")
    }
    
    func waitForElementToAppear(element: XCUIElement, timeout: NSTimeInterval = 5,  file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectationForPredicate(existsPredicate,evaluatedWithObject: element, handler: nil)
        waitForExpectationsWithTimeout(timeout) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after \(timeout) seconds."
                self.recordFailureWithDescription(message, inFile: file, atLine: line, expected: true)
            }
        }
    }
    
}


