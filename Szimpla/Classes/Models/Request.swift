import Foundation
import SwiftyJSON

/**
 *  Model that represents an HTTP Request
 */
internal struct Request {
    
    // MARK: - Attributes
    
    /// Body dictionary
    internal let body: JSON
    
    /// Base url
    internal let url: String
    
    /// URL parameters
    internal let parameters: [String: String]
    
}


// MARK: - Request Extension (Equatable)

extension Request: Equatable {}

internal func ==(lhs: Request, rhs: Request) -> Bool {
    return lhs.body == rhs.body &&
    lhs.url == rhs.url &&
    lhs.parameters == rhs.parameters
}