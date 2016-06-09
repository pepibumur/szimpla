import Foundation
import Quick
import Nimble

@testable import Szimpla

class SnapshotFetcherSpec: QuickSpec {
    
    override func spec() {
        var subject: SnapshotFetcher!
        var snapshot: Result<Snapshot, SnapshotFetchError>!
        
        beforeSuite {
            subject  = SnapshotFetcher(name: "test_snapshot")
        }
        
        describe("-fetch") {
            context("when the snapshot exists") {
                beforeEach {
                    snapshot = subject.fetch()
                }
                
//                it("should return the correct snapshot") {
//                    //TODO
//                    expect(snapshot.value) == testSpanshot()
//                }
            }
            
            context("when the snapshot doesn't exist") {
                beforeEach {
                    snapshot = subject.fetch()
                }
                
//                it("should return a not found error") {
//                    //TODO
//                    expect(snapshot.error) == SnapshotFetchError.NotFound
//                }
            }
        }
    }
    
}

private func testSpanshot() -> Snapshot {
    return Snapshot(parameters: ["param": "value"], headers: ["header": "value"], body: ["body": "value"])
}