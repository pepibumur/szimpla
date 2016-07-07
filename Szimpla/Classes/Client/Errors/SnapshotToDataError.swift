import Foundation

internal enum SnapshotToDataError: ErrorType, CustomStringConvertible {
    
    case SerializationError(ErrorType)
    
    
    // MARK: - <CustomStringConvertible>
    
    var description: String {
        switch self {
        case .SerializationError(let error):
            return  "Error serializing the Snapshot: \(error)"
        }
    }
}