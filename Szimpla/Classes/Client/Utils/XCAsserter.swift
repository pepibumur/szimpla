import Foundation
import XCTest

public class XCAsserter {
    
    func assert(error: ErrorType) {
        Logger.logError("Error validating")
        XCTAssert(false, "Error validating, \(error)")
    }
    
}
