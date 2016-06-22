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
                    let snapshotRecorded = Snapshot(requests: [request1])
                    let snapshotLocal = Snapshot(requests: [request1, request2])
                    expect {
                        try subject.validate(recordedSnapshot: snapshotRecorded, localSnapshot: snapshotLocal)
                    }.to(throwError(errorType: SnapshotValidationError.self))
                }
            }
        
        }
        
    }
}


// MARK: - Helpers

private func generateRequest() -> Request {
    return Request(body: ["test":"value"], url: "url", parameters: ["param1":"value1"])
}