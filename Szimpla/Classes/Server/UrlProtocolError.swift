import Foundation

internal enum UrlProtocolError: ErrorType {
    case AlreadyRegistered
}

extension UrlProtocolError: CustomStringConvertible {
    var description: String {
        switch self {
        case .AlreadyRegistered:
            return "The Szimpla UrlProtocol has already been registered and can't be registered twice."
        }
    }
}