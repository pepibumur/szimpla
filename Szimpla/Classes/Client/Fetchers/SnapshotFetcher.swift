import Foundation

/// Fetches a Snapshot from the disk.
internal class SnapshotFetcher: Fetcher<Snapshot, SnapshotFetcherError> {
    
    // MARK: - Attributes
    
    /// Path where the Snapshot should be fetched from.
    private let path: String
    
    /// Adapter from NSData to Snapshot.
    private let dataToSnapshotAdapter: DataToSnapshotAdapter
    
    /// File Manager.
    private let fileManager: FileManager
    
    
    // MARK: - Init
    
    /**
     Initializes the SnapshotFetcher
     
     - parameter path:                  Path where the snapshot is located (disk).
     - parameter fileManager:           File manager instance.
     - parameter dataToSnapshotAdapter: Adapter from NSData to Snapshot.
     
     - returns: Initialized SnapshotFetcher.
     */
    internal init(path: String, fileManager: FileManager = FileManager.instance, dataToSnapshotAdapter: DataToSnapshotAdapter = DataToSnapshotAdapter()) {
        self.path = path
        self.fileManager = fileManager
        self.dataToSnapshotAdapter = dataToSnapshotAdapter
    }
    
    /**
     Static constructor for SnapshotFetcher.
     
     - parameter path: Path where the Snapshot should be fetched from.
     
     - returns: Initialized SnapshotFetcher.
     */
    internal static func withPath(path: String) -> SnapshotFetcher {
        return SnapshotFetcher(path: path)
    }
    
    
    // MARK: - Fetcher
    
    override func fetch() -> Result<Snapshot, SnapshotFetcherError>! {
        guard let data = self.fileManager.read(path: self.path) else {
            return Result.Error(SnapshotFetcherError.NotFound(path))
        }
        let snapshotResult = dataToSnapshotAdapter.adapt(data)
        if let error = snapshotResult.error {
            return Result.Error(.AdaptError(error))
        }
        return Result.Success(snapshotResult.value)
    }

}
