import Foundation
import Quick
import Nimble

@testable import Szimpla

class URLRequestFilterSpec: QuickSpec {
    override func spec() {
        
        var subject: URLRequestFilter!
        
        beforeEach {
            subject = "http://test.com"
        }
        
        it("should return false if the request doesn't match the filter url") {
            let request = Request(body: [:], url: "http://google.com", parameters: [:])
            expect(subject.include(request: request)).to(beFalse())
        }
        
    }
}