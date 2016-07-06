import Foundation

/**
 *  Protocol that defines a filter for requests
 */
public protocol RequestFilter {
    
    /**
     Returns true if the request must be included.
     
     - parameter request: request to be filtered.
     
     - returns: true if the request must be included
     */
    func include(request request: NSURLRequest) -> Bool
}