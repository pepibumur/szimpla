import Foundation
import Quick
import Nimble

@testable import Szimpla

class RequestToSnapshotAdapterSpec: QuickSpec {
    override func spec() {
        var request: NSMutableURLRequest!
        var subject: RequestsToSnapshotAdapter!
        var result: Result<Snapshot, RequestsToSnapshotError>!
        
        beforeSuite {
            subject = RequestsToSnapshotAdapter(name: "test")
        }
        
        describe("-adapt:") {
            
            beforeEach {
                request = NSMutableURLRequest(URL: NSURL(string: "http://test.com?param1=value1")!)
                request.allHTTPHeaderFields = ["bar": "foo"]
                request.HTTPBody = data(fromDictionary: ["one": "two"])
                result = subject.adapt([request])
            }
            
            
            context("when there's no url") {
                
                beforeEach {
                    request = NSMutableURLRequest()
                    result = subject.adapt([request])
                }
                
                it("it should return an EmptyURL error") {
                    expect(result.error).to(equal(RequestsToSnapshotError.EmptyURL))
                }
            }
            


            //TODO
//            it("should have the correct parameters") {
//                expect(result.value.parameters) == ["param1": "value1"]
//            }
            
        }
    }
}

private func data(fromDictionary dictionary: [String: AnyObject]) -> NSData {
    return try! NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions.PrettyPrinted)
}