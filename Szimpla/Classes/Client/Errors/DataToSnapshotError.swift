import Foundation

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