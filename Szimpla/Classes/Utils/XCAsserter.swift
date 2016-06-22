import Foundation
import XCTest

/// Util for asserting test errors
public class XCAsserter {
    
    func assert(withMessage message: String) {
        XCTAssert(false, message)
    }
    
}