import Quick
import Nimble

@testable import Szimpla

class RequestSpec: QuickSpec {
    override func spec() {
        describe("==") {
            it("should return true if both requests are the same") {
                let request1 = Request(body: ["body": "body"], url: "url", parameters: ["test": "test2"])
                let request2 = Request(body: ["body": "body"], url: "url", parameters: ["test": "test2"])
                expect(request1 == request2).to(beTrue())
            }
        }
    }
}