import Foundation

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