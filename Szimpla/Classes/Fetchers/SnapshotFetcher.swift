import Foundation

internal class SnapshotFetcher: Fetcher<Snapshot, SnapshotFetchError> {
    
    // MARK: - Attributes
    
    let name: String
    
    
    // MARK: - Init
    
    internal init(name: String) {
        self.name = name
    }

    
    // MARK: - Fetcher
    
    internal override func fetch() -> Result<Snapshot, SnapshotFetchError>! {
        guard let dir = NSProcessInfo.processInfo().environment["SZ_REFERENCE_DIR"] else {
            return Result.Error(.DirNotDefined)
        }
        let url = NSURL(fileURLWithPath: dir).URLByAppendingPathComponent(self.name)
        guard let data = NSData(contentsOfURL: url) else {
            return Result.Error(.NotFound)
        }
        let adaptResult = DataToSnapshotAdapter().adapt(data)
        if let adaptError = adaptResult.error {
            return Result.Error(.Adapt(adaptError))
        }
        return Result.Success(adaptResult.value)
    }
    
}

// MARK: - SnapshotFetchError

public enum SnapshotFetchError: ErrorType {
    case NotFound
    case DirNotDefined
    case Adapt(DataToSnapshotError)
}

extension SnapshotFetchError: Equatable {}

public func ==(lhs: SnapshotFetchError, rhs: SnapshotFetchError) -> Bool {
    switch lhs {
    case .NotFound:
        switch rhs {
        case .NotFound: return true
        default: return false
        }
    case .DirNotDefined:
        switch rhs {
        case .DirNotDefined: return true
        default: return false
        }
    case .Adapt(let lhsAdaptError):
        switch rhs {
        case .Adapt(let rhsAdaptError): return rhsAdaptError == lhsAdaptError
        default: return false
        }
    }
}