import Foundation
import XCTest

public class Szimpla {
    
    // MARK: - Instance
    
    public static var instance: Szimpla = Szimpla()
    
    
    // MARK: - Attributes
    
    private let requestsToSnapshotAdapter: RequestsToSnapshotAdapter
    private let requestFetcher: RequestFetcher
    private let snapshotFetcher: (name: String) -> SnapshotFetcher
    private let snapshotValidator: SnapshotValidator
    private let asserter: XCAsserter
    
    
    // MARK: - Init
    
    internal init(requestsToSnapshotAdapter: RequestsToSnapshotAdapter, snapshotValidator: SnapshotValidator, requestFetcher: RequestFetcher, snapshotFetcher: (String) -> SnapshotFetcher,
                  asserter: XCAsserter = XCAsserter()) {
        self.requestsToSnapshotAdapter = requestsToSnapshotAdapter
        self.snapshotValidator = snapshotValidator
        self.requestFetcher = requestFetcher
        self.snapshotFetcher = snapshotFetcher
        self.asserter = asserter
    }
    
    public convenience init() {
        self.init(requestsToSnapshotAdapter: RequestsToSnapshotAdapter(), snapshotValidator: SnapshotValidator(), requestFetcher: RequestFetcher(), snapshotFetcher: SnapshotFetcher.withName)
    }
    
    
    // MARK: - Public
    
    public func start() throws {
        try self.requestFetcher.tearUp()
    }
    
    public func record(name name: String!, filter: RequestFilter! = nil) {
        let requests = self.requestFetcher.tearDown(filter: filter)
    }
    
    internal func validate(name: String) throws {
        let testRequests = self.requestFetcher.tearDown()
        let snapshotResult = self.requestsToSnapshotAdapter.adapt(testRequests)
        if snapshotResult.error != nil {
            throw SzimplaValidationError(message: "SZIMPLA: Test ~~\(name)~~ failed fetching the requests")
            return
        }
        let localSnapshotResult = self.snapshotFetcher(name: name).fetch()
        if localSnapshotResult.error != nil {
            throw SzimplaValidationError(message: "SZIMPLA: Test ~~\(name)~~ not found")
            return
        }
        let validationResult = self.snapshotValidator.validate(snapshotResult.value, localSnapshot: localSnapshotResult.value)
        if validationResult.error != nil {
            throw SzimplaValidationError(message: "SZIMPLA: Test ~~\(name)~~ validation failed:\n\(validationResult.error)")
            return
        }
    }
    
//    public func validate(name: String) {
//        
//    }
//    
}


// MARK: - SzimplaValidationError

public struct SzimplaValidationError: ErrorType {
    let message: String
}