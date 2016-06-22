import Foundation
import Quick
import Nimble

@testable import Szimpla

class SnapshotSpec: QuickSpec {
    override func spec() {
        describe("==") {
            it("should return true if both snapshots are the same") {
                let request = Request(body: [:], url: "", parameters: [:])
                let snapshot1 = Snapshot(requests: [request])
                let snapshot2 = Snapshot(requests: [request])
                expect(snapshot1 == snapshot2).to(beTrue())
            }
        }
    }
}