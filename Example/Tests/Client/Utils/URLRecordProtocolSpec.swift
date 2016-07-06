import Foundation
import Quick
import Nimble

@testable import Szimpla

class URLRecordProtocolSpec: QuickSpec {
    override func spec() {
        
        afterEach {
           URLRecordProtocol.tearDown()
        }
        
        it("should assert if tearUp is called consecutively without tearDown first") {
            try! URLRecordProtocol.tearUp()
            expect { try URLRecordProtocol.tearUp() }.to(throwError())
        }
        
        it("should register all sent requests") {
            try! URLRecordProtocol.tearUp()
            let request = NSURLRequest()
            URLRecordProtocol.canInitWithRequest(request)
            let recordedRequests = URLRecordProtocol.tearDown()
            expect(recordedRequests.first) == request
        }
        
        it("should clean the registered requests once the recording finishes") {
            try! URLRecordProtocol.tearUp()
            let request = NSURLRequest()
            URLRecordProtocol.canInitWithRequest(request)
            _ = URLRecordProtocol.tearDown()
            expect(URLRecordProtocol.requests.count) == 0
        }
        
    }
}