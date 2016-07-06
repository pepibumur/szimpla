import Foundation
import Quick
import Nimble

@testable import Szimpla

class DataToSnapshotAdapterSpec: QuickSpec {
    override func spec() {
        
        var subject: DataToSnapshotAdapter!
        var data: NSData!
        var result: Result<Snapshot,DataToSnapshotError>!
        
        beforeSuite {
            subject = DataToSnapshotAdapter()
        }
        
        describe("-adapt:") {
            context("when the parameters are missing") {
                beforeEach {
                    data = testData(withParameters: false, withHeaders: true, withBody: true)
                    result = subject.adapt(data)
                }
                it("should return the correct error") {
                    expect(result.error) == DataToSnapshotError.WrongFormat("Missing parameters")
                }
            }
            context("when the headers are missing") {
                beforeEach {
                    data = testData(withParameters: true, withHeaders: false, withBody: true)
                    result = subject.adapt(data)
                }
                it("should return the correct error") {
                    expect(result.error) == DataToSnapshotError.WrongFormat("Missing headers")
                }
            }
            
            context("when the body is missing") {
                beforeEach {
                    data = testData(withParameters: true, withHeaders: true, withBody: false)
                    result = subject.adapt(data)
                }
                it("should return the correct error") {
                    expect(result.error) == DataToSnapshotError.WrongFormat("Missing body")
                }
            }
            
            context("when the data is correct") {
                beforeEach {
                    data = testData(withParameters: true, withHeaders: true, withBody: true)
                    result = subject.adapt(data)
                }
            }
        }
        
    }
}


private func testData(withParameters withParameters: Bool, withHeaders: Bool, withBody: Bool) -> NSData {
    var dictionary: [String: AnyObject] = [:]
    if withParameters {
        dictionary["parameters"] = ["param": "value"]
    }
    if withHeaders {
        dictionary["headers"] = ["header": "value"]
    }
    if withBody {
        dictionary["body"] = ["body": "value"]
    }
    return try! NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions.PrettyPrinted)
}