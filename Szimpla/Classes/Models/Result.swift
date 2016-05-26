import Foundation

internal enum Result<T, E: ErrorType> {
    
    case Success(T)
    case Error(E)
    
    internal var error: E! {
        switch self {
        case .Error(let error): return error
        case .Success(_): return nil
        }
    }
    
    internal var value: T! {
        switch self {
        case .Error(_): return nil
        case .Success(let value): return value
        }
    }

}
