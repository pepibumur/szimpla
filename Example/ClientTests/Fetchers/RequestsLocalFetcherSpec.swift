import Foundation
import Quick
import Nimble

@testable import Szimpla

class RequestsLocalFetcherSpec: QuickSpec {
    override func spec() {
        var subject: RequestsLocalFetcher!
        var fileManager: MockFileManager!
        
        describe("-fetch") {
            context("when the data doesn't exist") {
                it("should throw an error") {
                    fileManager = MockFileManager()
                    subject = RequestsLocalFetcher(path: "path", fileManager: fileManager)
                    expect {
                        try subject.fetch()
                    }.to(throwError())
                }
            }
            
            context("when data exists") {
                it("should return the data") {
                    fileManager = MockFileManager(data: NSData())
                    subject = RequestsLocalFetcher(path: "path", fileManager: fileManager)
                    let requests = try! subject.fetch()
                    expect(requests).toNot(beNil())
                }
            }
        }
    
    }
}


// MARK: - Private

private class MockFileManager: FileManager {
    
    let data: NSData!
    
    init(data: NSData! = nil) {
        self.data = data
        super.init(basePath: "")
    }
    
    private override func read(path path: String) -> NSData? {
        return self.data
    }
    
}