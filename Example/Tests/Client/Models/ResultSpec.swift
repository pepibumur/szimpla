import Foundation
import Quick
import Nimble

@testable import Szimpla

class ResultSpec: QuickSpec {

    override func spec() {
        
        var result: Result<String, Error>!
        
        describe("error") {
            context("when it's an .Error") {
                beforeEach {
                    result = Result.Error(Error(name: "test"))
                }
                it("should return an the error") {
                    expect(result.error) == Error(name: "test")
                }
            }
            context("when it's a .Success") {
                beforeEach {
                    result = Result.Success("value")
                }
                it("should return nil") {
                    expect(result.error).to(beNil())
                }
            }
        }
        
        describe("value") {
            context("when it's an .Error") {
                beforeEach {
                    result = Result.Error(Error(name: "test"))
                }
                it("should return nil") {
                    expect(result.value).to(beNil())
                }
            }
            context("when it's a .Success") {
                beforeEach {
                    result = Result.Success("value")
                }
                it("should return the value") {
                    expect(result.value) == "value"
                }
            }
        }
        
    }
    
}

// MARK: - Private

private struct Error: ErrorType, Equatable {
    let name: String
}
private func ==(lhs: Error, rhs: Error) -> Bool {
    return lhs.name == rhs.name
}