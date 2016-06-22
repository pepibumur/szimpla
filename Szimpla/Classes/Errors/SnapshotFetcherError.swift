import Foundation

/**
 Error fetching the Snapshots.
 
 - AdaptError: Error adapting the snapshot from NSData.
 - NotFound:   The snapshot couldn't be found.
 */
internal enum SnapshotFetcherError: ErrorType, CustomStringConvertible {
    case AdaptError(DataToSnapshotError)
    case NotFound(String)
    
    
    // MARK: - <CustomStringConvertible>
    
    var description: String {
        switch self {
        case .AdaptError(let error):
            return "Error adapting NSData into Snapshot: \(error)"
        case .NotFound(let path):
            return "The snapshot at path \(path) couldn't be found"
        }
    }
}