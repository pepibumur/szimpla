import Foundation
import Quick
import Nimble

@testable import Szimpla

class SnapshotValidatorSpec: QuickSpec {
    override func spec() {
        
        var subject: SnapshotValidator!
        
        beforeEach {
            subject = SnapshotValidator()
        }
        
        describe("-validate:testSnapshot:localSnapshot:") {
            expect(true).to(beFalse()) // TODO
        }
        
    }
}