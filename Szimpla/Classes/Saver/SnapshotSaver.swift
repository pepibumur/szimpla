import Foundation

/// Saves snapshots into the disk.
internal class SnapshotSaver: Saver<(name: String, snapshot: Snapshot), SnapshotSaverError> {

    // MARK: - Attributes
    
    /// File Manager
    private let fileManager: FileManager
    
    /// Adapter that adapts snapshots into data.
    private let snapshotToDataAdapter: SnapshotToDataAdapter
    
    
    // MARK: - Init
    
    /**
     SnapshotSaver default constructor.
     
     - parameter fileManager:           File manager.
     - parameter snapshotToDataAdapter: Adapter from Snapshot to NSData.
     
     - returns: Initialized SnapshotSaver.
     */
    internal init(fileManager: FileManager = FileManager.instance, snapshotToDataAdapter: SnapshotToDataAdapter = SnapshotToDataAdapter()) {
        self.fileManager = fileManager
        self.snapshotToDataAdapter = snapshotToDataAdapter
    }
    
    
    // MARK: - Saver
    
    override func save(input: (path: String, snapshot: Snapshot)) -> Result<Void, SnapshotSaverError> {
        let dataResult = self.snapshotToDataAdapter.adapt(input.snapshot)
        if let adaptError = dataResult.error {
            return Result.Error(.AdaptError(adaptError))
        }
        do {
            try self.fileManager.save(data: dataResult.value, path: input.path)
            return Result.Success(())
        }
        catch {
            return Result.Error(.SaveError(error))
        }
    }
    
}
