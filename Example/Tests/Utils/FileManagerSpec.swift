import Foundation
import Quick
import Nimble

@testable import Szimpla

class FileManagerSpec: QuickSpec {
    override func spec() {
        
        var subject: FileManager!
        
        beforeEach {
            subject = FileManager.instance
            
            let dictionary: [String: String] = ["test": "value"]
            let data = try! NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions.PrettyPrinted)
            try! subject.save(data: data, path: "test")
        }
        
        afterEach {
            try! subject.remove(path: "test")
        }
        
        it("-read:") {
            let data = subject.read(path: "test")
            expect(data).toNot(beNil())
        }
    }
}