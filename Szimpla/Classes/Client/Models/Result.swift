import Foundation

/**
 Represents a result.
 
 - Success: The result is successful.
 - Error:   The result is an error.
 */
internal enum Result<T, E: ErrorType> {
    
    case Success(T)
    case Error(E)
    
    /// Returns an error if the result is an error.
    internal var error: E! {
        switch self {
        case .Error(let error): return error
        case .Success(_): return nil
        }
    }
    
    /// Returns the value if the result is a success.
    internal var value: T! {
        switch self {
        case .Error(_): return nil
        case .Success(let value): return value
        }
    }

}
