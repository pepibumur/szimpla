import Foundation

public enum SnapshotValidationError: ErrorType, CustomStringConvertible {
    
    case InvalidCount(expected: Int, got: Int)
    case InvalidType(key: String, expected: String, got: String)
    case InvalidValue(key: String, expected: String, got: String)
    case NotFound(key: String)
    
    
    // MARK: - <CustomStringConvertible>
    
    public var description: String {
        switch self {
        case .InvalidCount(let expected, let got):
            return "Invalid number of requests. Expected \(expected) but got \(got)"
        case .InvalidType(let key, let expected, let got):
            return "Invalid type for key: \(key). Expected type \(expected) but got \(got) instead"
        case .InvalidValue(let key, let expected, let got):
            return "Invalid value for key: \(key). Expected value \(expected) but got \(got) instead"
        case .NotFound(let key):
            return "Value for key \(key) not found)"
        default:
            return ""
        }
    }
}