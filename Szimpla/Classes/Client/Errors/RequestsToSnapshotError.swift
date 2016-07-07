import Foundation

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