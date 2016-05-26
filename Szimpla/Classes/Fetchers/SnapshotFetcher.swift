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
        return nil
    }
    
}

// MARK: - SnapshotFetchError

public enum SnapshotFetchError: ErrorType {
    case NotFound
}