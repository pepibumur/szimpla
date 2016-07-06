import Foundation

/// Saves snapshots into the disk.
internal class SnapshotSaver: Saver<Snapshot, SnapshotSaverError> {

    // MARK: - Attributes
    
    /// File Manager
    private let fileManager: FileManager
    
    /// Adapter that adapts snapshots into data.
    private let snapshotToDataAdapter: SnapshotToDataAdapter
    
    /// Path where the snapshot will be saved.
    private let path: String
    
    // MARK: - Init
    
    /**
     SnapshotSaver default constructor.
     
     - parameter fileManager:           File manager.
     - parameter snapshotToDataAdapter: Adapter from Snapshot to NSData.
     
     - returns: Initialized SnapshotSaver.
     */
    internal init(path: String, fileManager: FileManager = FileManager.instance, snapshotToDataAdapter: SnapshotToDataAdapter = SnapshotToDataAdapter()) {
        self.path = path
        self.fileManager = fileManager
        self.snapshotToDataAdapter = snapshotToDataAdapter
    }
    
    
    // MARK: - Saver
    
    override func save(snapshot: Snapshot) -> Result<Void, SnapshotSaverError> {
        let dataResult = self.snapshotToDataAdapter.adapt(snapshot)
        if let adaptError = dataResult.error {
            return Result.Error(.AdaptError(adaptError))
        }
        do {
            try self.fileManager.save(data: dataResult.value, path: self.path)
            return Result.Success(())
        }
        catch {
            return Result.Error(.SaveError(error))
        }
    }
    
}
