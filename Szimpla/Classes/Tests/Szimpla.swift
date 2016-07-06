import Foundation

public class Szimpla {
    
    // MARK: - Instance
    
    public static var instance: Szimpla = Szimpla()
    
    
    // MARK: - Attributes
    
    private let requestsToSnapshotAdapter: RequestsToSnapshotAdapter
    private let requestFetcher: RequestFetcher
    private let snapshotFetcher: (path: String) -> SnapshotFetcher
    private let snapshotValidator: Validator
    private let asserter: XCAsserter
    
    
    // MARK: - Init
    
    internal init(requestsToSnapshotAdapter: RequestsToSnapshotAdapter,
                  snapshotValidator: Validator,
                  requestFetcher: RequestFetcher,
                  snapshotFetcher: (String) -> SnapshotFetcher,
                  asserter: XCAsserter = XCAsserter()) {
        self.requestsToSnapshotAdapter = requestsToSnapshotAdapter
        self.snapshotValidator = snapshotValidator
        self.requestFetcher = requestFetcher
        self.snapshotFetcher = snapshotFetcher
        self.asserter = asserter
    }
    
    public convenience init() {
        self.init(requestsToSnapshotAdapter: RequestsToSnapshotAdapter(), snapshotValidator: DefaultValidator(), requestFetcher: RequestFetcher(), snapshotFetcher: SnapshotFetcher.withPath)
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
     
     - parameter name:   Path where the recorded requests will be saved.
     - parameter filter: Filter used for selecting which requests should be recorded.
     */
    public func record(path path: String, filter: RequestFilter! = nil) throws {
        let requests = self.requestFetcher.tearDown(filter: filter)
        let snapshotResult = self.requestsToSnapshotAdapter.adapt(requests)
        if snapshotResult.error != nil {
            throw SzimplaValidationError(message: "SZIMPLA: Test ~~\(path)~~ failed fetching the requests.")
            return
        }
        let snapshot: Snapshot = snapshotResult.value
        let saver: SnapshotSaver = SnapshotSaver(path: path)
        let saveResult = saver.save(snapshot)
        if let saveError = saveResult.error {
            throw saveError
        }
    }
    
    /**
     Validates if the recorded requests match the previously recorded with the provided name.
     
     - parameter path: Path of the previously recorded requests.
     */
    public func validate(path path: String) {
        do {
            try self._validate(path: path)
        }
        catch where error is SzimplaValidationError {
            let validationError = error as! SzimplaValidationError
            self.asserter.assert(withMessage: validationError.message)
        }
        catch {
            self.asserter.assert(withMessage: "SZIMPLA: Test ~~\(path)~~ unexpected error.")
        }
    }
    
    
    // MARK: - Internal
    
    internal func _validate(path path: String) throws {
        let requests = self.requestFetcher.tearDown()
        let snapshotResult = self.requestsToSnapshotAdapter.adapt(requests)
        if snapshotResult.error != nil {
            throw SzimplaValidationError(message: "SZIMPLA: Test ~~\(path)~~ failed fetching the requests.")
            return
        }
        let localSnapshotResult = self.snapshotFetcher(path: path).fetch()
        if localSnapshotResult.error != nil {
            throw SzimplaValidationError(message: "SZIMPLA: Test ~~\(path)~~ not found.")
            return
        }
        do {
            try self.snapshotValidator.validate(recordedSnapshot: snapshotResult.value, localSnapshot: localSnapshotResult.value)
        }
        catch {
            throw SzimplaValidationError(message: "SZIMPLA: Test ~~\(path)~~ validation failed:\n\(error)")
        }
    }
    
}


// MARK: - SzimplaValidationError

public struct SzimplaValidationError: ErrorType {
    let message: String
}