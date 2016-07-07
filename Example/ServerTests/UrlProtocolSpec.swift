import Foundation
import Quick
import Nimble
import NSURL_QueryDictionary

@testable import Szimpla

class UrlProtocolSpec: QuickSpec {
    override func spec() {
        
        afterEach {
            UrlProtocol.stop()
        }
        
        describe("-start") {
            it("should remove all the requests") {
                UrlProtocol.requests.append([:])
                try! UrlProtocol.start()
                expect(UrlProtocol.requests.count) == 0
            }
            
            it("should throw an error if it's registered twice") {
                try! UrlProtocol.start()
                expect {
                    try UrlProtocol.start()
                }.to(throwError())
            }
        }
        
        describe("-stop") {
            it("should return the registered requests") {
                UrlProtocol.requests.append([:])
                expect(UrlProtocol.stop()) == [[:]]
            }
            it("should clean the registered requests") {
                UrlProtocol.requests.append([:])
                _ = UrlProtocol.stop()
                expect(UrlProtocol.requests.count) == 0
            }
        }
        
        describe("-canInitWithRequest:") {
            
            var dictionary: [String: AnyObject]!
            
            beforeEach {
                let request = NSMutableURLRequest(URL: NSURL(string: "http://test.com")!.uq_URLByAppendingQueryDictionary(["param1": "value1"]))
                request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(["body1": "value1"], options: NSJSONWritingOptions.PrettyPrinted)
                UrlProtocol.canInitWithRequest(request)
                dictionary = UrlProtocol.requests.first!
            }
        
            describe("request dictionary") {
                it("should have the correct url") {
                    expect(dictionary["url"] as? String) == "http://test.com?param1=value1"
                }
                it("should have the correct parameters") {
                    expect(dictionary["parameters"] as? [String: String]) == ["param1": "value1"]
                }
                it("should have the correct body") {
                    expect(dictionary["body"] as? [String: String]) == ["body1": "value1"]
                }
            }
        }
        
    }
}