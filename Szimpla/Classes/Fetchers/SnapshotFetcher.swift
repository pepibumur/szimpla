import Foundation

internal class SnapshotFetcher: Fetcher<Snapshot, SnapshotFetcherError> {
    
    // MARK: - Attributes
    
    private let name: String
    private let dataToSnapshotAdapter: DataToSnapshotAdapter
    private let fileManager: FileManager
    
    
    // MARK: - Init
    
    internal init(name: String, fileManager: FileManager = FileManager.instance, dataToSnapshotAdapter: DataToSnapshotAdapter = DataToSnapshotAdapter()) {
        self.name = name
        self.fileManager = fileManager
        self.dataToSnapshotAdapter = dataToSnapshotAdapter
    }
    
    internal static func withName(name: String) -> SnapshotFetcher {
        return SnapshotFetcher(name: name)
    }
    
    
    // MARK: - Fetcher
    
    override func fetch() -> Result<Snapshot, SnapshotFetcherError>! {
        guard let data = self.fileManager.read(path: self.path(fromName: self.name)) else {
            return Result.Error(.NotFound)
        }
        let snapshotResult = dataToSnapshotAdapter.adapt(data)
        if let error = snapshotResult.error {
            return Result.Error(.AdaptError(error))
        }
        return Result.Success(snapshotResult.value)
    }

    
    // MARK: - Private
    
    private func path(fromName name: String) -> String {
        return "\(name).json"
    }
    
}

// MARK: - SnapshotFetcherError

internal enum SnapshotFetcherError: ErrorType {
    case AdaptError(DataToSnapshotError)
    case NotFound
}