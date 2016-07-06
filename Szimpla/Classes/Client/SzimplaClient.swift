import Foundation

@objc public class SzimplaClient: NSObject {
    
    // MARK: - Instance
    
    public static var instance: SzimplaClient = SzimplaClient()
    
    
    // MARK: - Attributes
    
    private let requestFetcher: RequestFetcher
    private let snapshotFetcher: (path: String) -> SnapshotFetcher
    private let fileManager: FileManager
    private let snapshotValidator: Validator
    private let dataToSnapshotAdapter: DataToSnapshotAdapter
    private let asserter: XCAsserter
    
    
    // MARK: - Init
    
    internal init(snapshotValidator: Validator,
                  requestFetcher: RequestFetcher,
                  snapshotFetcher: (String) -> SnapshotFetcher,
                  fileManager: FileManager,
                  dataToSnapshotAdapter: DataToSnapshotAdapter,
                  asserter: XCAsserter = XCAsserter()) {
        self.snapshotValidator = snapshotValidator
        self.requestFetcher = requestFetcher
        self.snapshotFetcher = snapshotFetcher
        self.fileManager = fileManager
        self.dataToSnapshotAdapter = dataToSnapshotAdapter
        self.asserter = asserter
    }
    
    public convenience override init() {
        self.init(snapshotValidator: DefaultValidator(), requestFetcher: RequestFetcher(), snapshotFetcher: SnapshotFetcher.withPath, fileManager: FileManager.instance, dataToSnapshotAdapter: DataToSnapshotAdapter())
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
        let _requestsData = self.requestFetcher.tearDown(filter: filter)
        guard let requestsData = _requestsData else { return } // TODO - Throw error if there's no data
        try self.fileManager.save(data: requestsData, path: path)
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
    
    internal func _validate(path path: String, filter: RequestFilter! = nil) throws {
        let _requestsData = self.requestFetcher.tearDown(filter: filter)
        guard let requestsData = _requestsData else { return } // TODO - Throw error if there's no data
        let snapshotResult = self.dataToSnapshotAdapter.adapt(requestsData)
        if snapshotResult.error != nil {
            throw SzimplaValidationError(message: "SZIMPLA: Test ~~\(path)~~ failed fetching the requests.")
        }
        let localSnapshotResult = self.snapshotFetcher(path: path).fetch()
        if localSnapshotResult.error != nil {
            throw SzimplaValidationError(message: "SZIMPLA: Test ~~\(path)~~ not found.")
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