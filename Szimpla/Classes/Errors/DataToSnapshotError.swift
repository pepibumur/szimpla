import Foundation

/**
 Error when adapting NSData into Snapshot.
 
 - WrongFormat: The input format is invalid.
 */
internal enum DataToSnapshotError: ErrorType, CustomStringConvertible {
    case WrongFormat(String)
    
    // MARK: - <StringLiteralConvertible>
    
    var description: String {
        switch self {
        case .WrongFormat(let description):
            return description
        }
    }
}