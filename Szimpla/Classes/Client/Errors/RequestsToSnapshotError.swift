import Foundation

/**
 Error converting [NSURLRequest] into Snapshot
 
 - EmptyURL: The URL is missing.
 */
internal enum RequestsToSnapshotError: ErrorType, CustomStringConvertible {
    case EmptyURL
    
    
    // MARK: <CustomStringConvertible>
    
    var description: String {
        switch self {
        case .EmptyURL:
            return "The request URL is empty"
        }
    }
}