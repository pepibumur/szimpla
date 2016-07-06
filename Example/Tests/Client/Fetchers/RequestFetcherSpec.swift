import Foundation
import Quick
import Nimble

@testable import Szimpla

class RequestFetcherSpec: QuickSpec {
    
    override func spec() {
        
        var subject: RequestFetcher!
        var filter: URLRequestFilter!
        
        beforeEach {
            filter = "http://test.com"
            subject = RequestFetcher()
        }
        
        afterEach {
            subject.tearDown()
        }
        
        describe("-tearUp") {
            it("should register the URLRecordProtocol") {
                try! subject.tearUp()
                expect(URLRecordProtocol.registered).to(beTrue())
            }
        }
        
        
        describe("-tearDown") {
            it("should unregister the URLRecordProtocol") {
                try! subject.tearUp()
                subject.tearDown()
                expect(URLRecordProtocol.registered).to(beFalse())
            }
            
            it("should return the requests filtered") {
                try! subject.tearUp()
                URLRecordProtocol.canInitWithRequest(NSURLRequest(URL: NSURL(string: "http://google.com")!))
                URLRecordProtocol.canInitWithRequest(NSURLRequest(URL: NSURL(string: "http://test.com")!))
                let requests = subject.tearDown(filter: filter)
                expect(requests.count) == 1
            }
        }
        
    }
    
}