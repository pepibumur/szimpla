import Foundation
import Quick
import Nimble

@testable import Szimpla

class DefaultValidatorSpec: QuickSpec {
    override func spec() {
        
        var subject: DefaultValidator!
        
        beforeEach {
            subject = DefaultValidator()
        }
        
        describe("-validate:recordedSnapshot:localSnapshot:") {
            
            context("when the number of requests doesn't match") {
                it("should throw an invalid count error") {
                    let request1 = generateRequest()
                    let request2 = generateRequest()
                    expect {
                        try subject.validate(recordedRequests: [request1], localRequests: [request1, request2])
                    }.to(throwError(errorType: SnapshotValidationError.self))
                }
            }
            
            context("when requests match") {
                it("shouldn't throw an error") {
                    let recorded = Request(body: ["test1": "value1", "test2": 2, "test3": ["test11": "value11"]], url: "test.com", parameters: ["test1": "value1", "test2": "value2"])
                    let local = Request(body: ["test2": 2, "test3": ["test11": "value11"]], url: "test.com", parameters: ["test1": "value1"])
                    expect {
                        try subject.validate(recordedRequests: [recorded], localRequests: [local])
                    }
                    .toNot(throwError())
                }
            }
            
            context("when requests do not match") {
                it("should throw an error") {
                    let recorded = Request(body: ["test1": "value1", "test2": 2, "test3": ["test11": "value11"]], url: "test.com", parameters: ["test1": "value1", "test2": "value2"])
                    let local = Request(body: ["test2": 5, "test3": ["test11": "value11"]], url: "test.com", parameters: ["test1": "value1"])
                    expect {
                        try subject.validate(recordedRequests: [recorded], localRequests: [local])
                        }
                    .to(throwError())
                }
            }
        }
        
    }
}


// MARK: - Helpers

private func generateRequest() -> Request {
    return Request(body: ["test":"value"], url: "url", parameters: ["param1":"value1"])
}