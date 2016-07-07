import XCTest
import Quick
import Nimble
import Swifter

@testable import Szimpla

class ServerSpec: QuickSpec {
    override func spec() {
        
        var subject: Server!
        var httpServer: MockServer!
        
        beforeEach {
            httpServer = MockServer()
            subject = Server(server: httpServer)
        }
        
        describe("-sessionConfiguration:") {
            it("should include the URLProtocol") {
                let inputConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
                let outputConfiguration = subject.sessionConfiguration(fromConfiguration: inputConfiguration)
                expect(outputConfiguration.protocolClasses?.first).to(be(UrlProtocol.self))
            }
        }
        
        describe("-tearUp") {
            beforeEach {
                try! subject.tearUp()
            }
            it("should start the server") {
                expect(httpServer.startCalled) == true
            }
            it("should register the /stop endpoint") {
                expect(httpServer.routes.indexOf("/stop")).toNot(beNil())
            }
            it("should register the /start endpoint") {
                expect(httpServer.routes.indexOf("/start")).toNot(beNil())
            }
            it("should throw an error if we try to start twice") {
                expect {
                    try subject.tearUp()
                }.to(throwError())
            }
        }
        
        describe("-tearDown") {
            beforeEach {
                subject.tearDown()
            }
            it("should stop the server") {
                expect(httpServer.stopCalled) == true
            }
        }
        
    }
}


// MARK: - Private

class MockServer: HttpServer {
    
    var startCalled: Bool = false
    var stopCalled: Bool = false
    
    override func start(listenPort: in_port_t, forceIPv4: Bool) throws {
        self.startCalled = true
    }
    
    override func stop() {
        self.stopCalled = true
    }
}