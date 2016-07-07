import Foundation
import Quick
import Nimble
import SwiftyJSON

@testable import Szimpla

class RequestSpec: QuickSpec {
    
    override func spec() {

        var request: Request!
        
        describe("-adapt:") {
            beforeEach {
                let json =
                    ["url": "url",
                        "parameters": ["key": "parameter"],
                        "body": ["key": "body"]]
                request = Request(json: JSON(json))
            }
            
            describe("request") {
                it("should have the correct url") {
                    expect(request.url) == "url"
                }
                it("should have the correct parameters") {
                    expect(request.parameters) == ["key": "parameter"]
                }
                it("should have the correct body") {
                    expect(request.body) == ["key": "body"]
                }
            }
        }
        
        describe("-toDict") {
            var subject: Request!
            var dict: [NSObject: AnyObject]!
            
            beforeEach {
                subject = Request(body: ["body": "value"], url: "url", parameters: ["param": "value"])
                dict = subject.toDict()
            }
            
            it("should have the url at the correct key") {
                let url = dict["url"] as! String
                expect(url) == "url"
            }
            
            it("should have the parameters at the correct key") {
                let parameters = dict["parameters"] as! [String: String]
                expect(parameters) == ["param": "value"]
            }
            
            it("should have the body at the correct key") {
                let body = dict["body"] as! [String: String]
                expect(body) == ["body": "value"]
            }
        }
        
    }
}
