import Foundation
import Quick
import Nimble

@testable import Szimpla

class RequestsRemoteFetcherSpec: QuickSpec {
    override func spec() {
        
        var subject: RequestsRemoteFetcher!
        var dispatcher: MockSyncUrlRequestDispatcher!
        
        describe("-tearUp") {
            context("when the dispatcher throws an error") {
                it("should throw an error") {
                    dispatcher = MockSyncUrlRequestDispatcher(error: NSError(domain: "", code: -1, userInfo: nil))
                    subject = RequestsRemoteFetcher(baseUrl: "http://test.com", syncUrlDispatcher: dispatcher)
                    expect {
                        try subject.tearUp()
                    }.to(throwError())
                }
            }
            context("when the dispatcher succeed") {
                it("shouldn't throw an error") {
                    let data: NSData = NSData()
                    dispatcher = MockSyncUrlRequestDispatcher(error: nil, data: data)
                    subject = RequestsRemoteFetcher(baseUrl: "http://test.com", syncUrlDispatcher: dispatcher)
                    expect {
                        try subject.tearUp()
                    }.toNot(throwError())
                }
            }
        }
        
        describe("-tearDown") {
            context("when the dispatcher throws an error") {
                it("should throw an error") {
                    dispatcher = MockSyncUrlRequestDispatcher(error: NSError(domain: "", code: -1, userInfo: nil))
                    subject = RequestsRemoteFetcher(baseUrl: "http://test.com", syncUrlDispatcher: dispatcher)
                    expect {
                        try subject.tearDown()
                        }.to(throwError())
                }
            }
            context("when the dispatcher succeed") {
                it("should return the data") {
                    let data: NSData = NSData()
                    dispatcher = MockSyncUrlRequestDispatcher(error: nil, data: data)
                    subject = RequestsRemoteFetcher(baseUrl: "http://test.com", syncUrlDispatcher: dispatcher)
                    let requests = try! subject.tearDown()
                    expect(requests).toNot(beNil())
                }
            }
            
            context("when a filter is provided") {
                it("should fiter the requests") {
                    let json =
                        [["url": "url",
                         "parameters": ["key": "parameter"],
                         "body": ["key": "body"]]]
                    let data = try! NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions.PrettyPrinted)
                    dispatcher = MockSyncUrlRequestDispatcher(error: nil, data: data)
                    subject = RequestsRemoteFetcher(baseUrl: "http://test.com", syncUrlDispatcher: dispatcher)
                    let requests = try! subject.tearDown(filter: MockRequestFilter())
                    expect(requests.count) == 0
                }
            }
            
        }
    }
}


// MARK: - Private

private class MockRequestFilter: RequestFilter {
    private func include(request request: Request) -> Bool {
        return false
    }
}

private class MockSyncUrlRequestDispatcher: SyncUrlRequestDispatcher {
    
    var error: NSError?
    var data: NSData?
    var dispatchedUrl: String!
    
    init(error: NSError?, data: NSData? = NSData()) {
        self.error = error
        self.data = data
    }
    
    private override func dispatch(url: String) throws -> NSData {
        if let error = error { throw error }
        return data!
    }
    
}