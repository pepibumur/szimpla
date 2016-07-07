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
        try! Szimpla.Client.instance.start()
        let app = XCUIApplication()
        sleep(1)
        app.buttons["Navigate"].tap()
        app.navigationBars["App.SecondView"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        XCTAssert(app.buttons["Navigate"].exists, "It couldn't navigate")
        Szimpla.Client.instance.validate(path: "CMDUConf.json")
    }
    
}


