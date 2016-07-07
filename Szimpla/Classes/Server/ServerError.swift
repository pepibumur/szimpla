import Foundation

internal enum ServerError: ErrorType {
    case AlreadyRunning
}

extension ServerError: CustomStringConvertible {
    var description: String {
        switch self {
        case .AlreadyRunning:
            return "Trying to start a Szimpla server that is already running"
        }
    }
}