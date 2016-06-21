import Foundation
import Quick
import Nimble

@testable import Szimpla

class RequestFetcherSpec: QuickSpec {
    
    override func spec() {
        
        var subject: RequestFetcher!
        
        describe("-tearDown") {
            
            context("when there's a base URL") {
                
                var baseURL: NSURL!
                
                beforeEach {
                    baseURL = NSURL(string: "http://test")
                    subject = RequestFetcher(baseURL: baseURL)
                }
                
            }
            
            context("when there isn't a base URL") {
                
                beforeEach {
                    subject = RequestFetcher()
                }
                
                it("should return all the requests") {
                    subject.tearUp()
                    NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://test")!).resume()
                    NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://test2")!).resume()
                    NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "http://test3")!).resume()
                    
                    waitUntil(timeout: 3, action: { (done) in
                        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.8 * Double(NSEC_PER_SEC)))
                        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                            expect(subject.tearDown().count) == 3
                            done()
                        })
                    })
                }
            }
            
        }
        
    }
    
}