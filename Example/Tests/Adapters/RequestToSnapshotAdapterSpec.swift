import Foundation
import Quick
import Nimble

@testable import Szimpla

class RequestToSnapshotAdapterSpec: QuickSpec {
    override func spec() {
        var request: NSMutableURLRequest!
        var subject: RequestToSnapshotAdapter!
        var result: Result<Snapshot, RequestToSnapshotError>!
        
        beforeSuite {
            subject = RequestToSnapshotAdapter()
        }
        
        describe("-adapt:") {
            
            beforeEach {
                request = NSMutableURLRequest(URL: NSURL(string: "http://test.com?param1=value1")!)
                request.allHTTPHeaderFields = ["bar": "foo"]
                request.HTTPBody = data(fromDictionary: ["one": "two"])
                result = subject.adapt(request)
            }
            
            
            context("when there's no url") {
                
                beforeEach {
                    request = NSMutableURLRequest()
                    result = subject.adapt(request)
                }
                
                it("it should return an EmptyURL error") {
                    expect(result.error).to(equal(RequestToSnapshotError.EmptyURL))
                }
            }
            
            it("should have the correct headers") {
                expect(result.value.headers) == ["bar": "foo"]
            }
            
            it("should have the correct body") {
                expect(result.value.body as? [String: String]) == ["one": "two"]
            }
            
            it("should have the correct parameters") {
                expect(result.value.parameters) == ["param1": "value1"]
            }
            
        }
    }
}

private func data(fromDictionary dictionary: [String: AnyObject]) -> NSData {
    return try! NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions.PrettyPrinted)
}