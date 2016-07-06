import Foundation

/**
 Possible errors when saving Snapshots into disk.
 
 - AdaptError: Error adapting the Snapshot into NSData.
 - SaveError:  Error saving the Snapshot into disk.
 */
internal enum SnapshotSaverError: ErrorType, CustomStringConvertible {
    case AdaptError(SnapshotToDataError)
    case SaveError(ErrorType)
    
    
    // MARK: - <CustomStringConvertible>
    
    var description: String {
        switch self {
        case .AdaptError(let error):
            return "Error adapting snapshot into NSData: \(error)"
        case .SaveError(let error):
            return "Error saving snapshot: \(error)"
        }
    }
}