import Foundation
import SwiftyJSON

/**
 *  Model that represents an HTTP Request
 */
public struct Request {
    
    // MARK: - Attributes
    
    /// Body dictionary
    public let body: JSON
    
    /// Base url
    public let url: String
    
    /// URL parameters
    public let parameters: [String: String]
    
}


// MARK: - Request Extension (Equatable)

extension Request: Equatable {}

public func ==(lhs: Request, rhs: Request) -> Bool {
    return lhs.body == rhs.body &&
    lhs.url == rhs.url &&
    lhs.parameters == rhs.parameters
}