import Foundation
import XCTest

public class Szimpla {
    
    // MARK: - Instance
    
    public static var instance: Szimpla = Szimpla()
    
    
    // MARK: - Attributes
    
    private let requestsToSnapshotAdapter: RequestsToSnapshotAdapter
    private let requestFetcher: RequestFetcher
    private let snapshotFetcher: (name: String) -> SnapshotFetcher
    private let snapshotValidator: Validator
    private let asserter: XCAsserter
    
    
    // MARK: - Init
    
    internal init(requestsToSnapshotAdapter: RequestsToSnapshotAdapter, snapshotValidator: Validator, requestFetcher: RequestFetcher, snapshotFetcher: (String) -> SnapshotFetcher,
                  asserter: XCAsserter = XCAsserter()) {
        self.requestsToSnapshotAdapter = requestsToSnapshotAdapter
        self.snapshotValidator = snapshotValidator
        self.requestFetcher = requestFetcher
        self.snapshotFetcher = snapshotFetcher
        self.asserter = asserter
    }
    
    public convenience init() {
        self.init(requestsToSnapshotAdapter: RequestsToSnapshotAdapter(), snapshotValidator: DefaultValidator(), requestFetcher: RequestFetcher(), snapshotFetcher: SnapshotFetcher.withName)
    }
    
    
    // MARK: - Public
    
    /**
     Starts recording requests.
     
     - throws: Throws an error if it cannot start recording.
     */
    public func start() throws {
        try self.requestFetcher.tearUp()
    }
    
    /**
     Saves the recorded requests with the given name.
     
     - parameter name:   Recorded requests name.
     - parameter filter: Filter used for selecting which requests should be recorded.
     */
    public func record(name name: String!, filter: RequestFilter! = nil) {
        let requests = self.requestFetcher.tearDown(filter: filter)
    }
    
    /**
     Validates if the recorded requests match the previously recorded with the provided name.
     
     - parameter name: Name of the previously recorded requests.
     */
    public func validate(name: String) {
        do {
            try self._validate(name)
        }
        catch where error is SzimplaValidationError {
            let validationError = error as! SzimplaValidationError
            self.asserter.assert(withMessage: validationError.message)
        }
        catch {
            self.asserter.assert(withMessage: "SZIMPLA: Test ~~\(name)~~ unexpected error.")
        }
    }
    
    
    // MARK: - Internal
    
    internal func _validate(name: String) throws {
        let testRequests = self.requestFetcher.tearDown()
        let snapshotResult = self.requestsToSnapshotAdapter.adapt(testRequests)
        if snapshotResult.error != nil {
            throw SzimplaValidationError(message: "SZIMPLA: Test ~~\(name)~~ failed fetching the requests.")
            return
        }
        let localSnapshotResult = self.snapshotFetcher(name: name).fetch()
        if localSnapshotResult.error != nil {
            throw SzimplaValidationError(message: "SZIMPLA: Test ~~\(name)~~ not found.")
            return
        }
        do {
            try self.snapshotValidator.validate(recordedSnapshot: snapshotResult.value, localSnapshot: localSnapshotResult.value)
        }
        catch {
            throw SzimplaValidationError(message: "SZIMPLA: Test ~~\(name)~~ validation failed:\n\(error)")
        }
    }
    
}


// MARK: - SzimplaValidationError

public struct SzimplaValidationError: ErrorType {
    let message: String
}