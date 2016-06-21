import Foundation

internal class SnapshotSaver: Saver<(name: String, snapshot: Snapshot), SnapshotSaverError> {

    // MARK: - Attributes
    
    private let fileManager: FileManager
    private let snapshotToDataAdapter: SnapshotToDataAdapter
    
    
    // MARK: - Init
    
    internal init(fileManager: FileManager = FileManager.instance, snapshotToDataAdapter: SnapshotToDataAdapter = SnapshotToDataAdapter()) {
        self.fileManager = fileManager
        self.snapshotToDataAdapter = snapshotToDataAdapter
    }
    
    
    
    // MARK: - Saver
    
    override func save(input: (name: String, snapshot: Snapshot)) -> Result<Void, SnapshotSaverError> {
        let dataResult = self.snapshotToDataAdapter.adapt(input.snapshot)
        if let adaptError = dataResult.error {
            return Result.Error(.AdaptError(adaptError))
        }
        do {
            try self.fileManager.save(data: dataResult.value, path: "\(input.name).json")
            return Result.Success(())
        }
        catch {
            return Result.Error(.SaveError(error))
        }
    }
    
}


// MARK: - SnapshotSaverError

internal enum SnapshotSaverError: ErrorType {
    case AdaptError(SnapshotToDataError)
    case SaveError(ErrorType)
}