import Foundation
import Quick
import Nimble

@testable import Szimpla

class SnapshotSpec: QuickSpec {
    override func spec() {
        describe("==") {
            it("should return true if both snapshots are the same") {
                let snapshotA: Snapshot = Snapshot(parameters: ["param": "value"], headers: ["header": "value"], body: ["body": "value"])
                let snapshotB: Snapshot = Snapshot(parameters: ["param": "value"], headers: ["header": "value"], body: ["body": "value"])
                expect(snapshotA == snapshotB) == true
            }
        }
    }
}