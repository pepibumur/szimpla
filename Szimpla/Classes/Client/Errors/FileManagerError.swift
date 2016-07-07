import Foundation

internal enum FileManagerError: ErrorType, CustomStringConvertible{
    
    case UndefinedReferenceDir
    
    
    // MARK: - <CustomStringConvertible>
    
    var description: String {
        switch self {
        case .UndefinedReferenceDir:
            return "Environment variable 'SZ_REFERENCE_DIR' not defined"
        }
    }
    
}
