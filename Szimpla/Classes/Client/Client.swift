import Foundation
import SwiftyJSON

@objc public class Client: NSObject {
    
    // MARK: - Instance
    
    public static var instance: Client = Client()
    
    
    // MARK: - Attributes
    
    private let requestsRemoteFetcher: RequestsRemoteFetcher
    private let requestsLocalFetcher: (path: String) -> RequestsLocalFetcher
    private let fileManager: FileManager
    private let requestsValidator: Validator
    private let asserter: XCAsserter
    
    
    // MARK: - Init
    
    internal init(requestsValidator: Validator,
                  requestsRemoteFetcher: RequestsRemoteFetcher,
                  requestsLocalFetcher: (String) -> RequestsLocalFetcher,
                  fileManager: FileManager,
                  asserter: XCAsserter = XCAsserter()) {
        self.requestsValidator = requestsValidator
        self.requestsRemoteFetcher = requestsRemoteFetcher
        self.requestsLocalFetcher = requestsLocalFetcher
        self.fileManager = fileManager
        self.asserter = asserter
    }
    
    public convenience override init() {
        self.init(requestsValidator: DefaultValidator(), requestsRemoteFetcher: RequestsRemoteFetcher(), requestsLocalFetcher: RequestsLocalFetcher.withPath, fileManager: FileManager.instance)
    }
    
    
    // MARK: - Public
    
    public func start() throws {
        try self.requestsRemoteFetcher.tearUp()
    }
    
    public func record(path path: String, filter: RequestFilter! = nil) throws {
        let requests = try self.requestsRemoteFetcher.tearDown(filter: filter)
        let requestsDicts = requests.map({$0.toDict()})
        let requestsData = try NSJSONSerialization.dataWithJSONObject(requestsDicts, options: NSJSONWritingOptions.PrettyPrinted)
        try self.fileManager.save(data: requestsData, path: path)
    }
    
    public func validate(path path: String, filter: RequestFilter! = nil) throws {
        do {
            let recordedRequests = try self.requestsRemoteFetcher.tearDown(filter: filter)
            let localRequests = try self.requestsLocalFetcher(path: path).fetch()
            try self.requestsValidator.validate(recordedRequests: recordedRequests, localRequests: localRequests)
        }
        catch {
            self.asserter.assert(error)
        }
    }
    
}
