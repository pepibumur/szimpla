import Foundation

internal class SpanshotFetcher: Fetcher<Snapshot, SnapshotFetchError> {
    
    // MARK: - Attributes
    
    let name: String
    
    
    // MARK: - Init
    
    init(name: String) {
        self.name = name
    }

    
    // MARK: - Fetcher
    
    override func fetch() -> Result<Snapshot, SnapshotFetchError>! {
        guard let dir = NSProcessInfo.processInfo().environment["SZ_REFERENCE_DIR"] else {
            return Result.Error(.DirNotDefined)
        }
        let url = NSURL(fileURLWithPath: dir)
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