import Foundation

/**
 *  Request filter that filters the requests according to its base URL.
 */
public struct URLRequestFilter: RequestFilter {
    
    // MARK: - Attributes
    
    /// Base url to filter the request.
    private let baseUrl: String
    
    
    // MARK: - <RequestFilter>
    
    public func include(request request: NSURLRequest) -> Bool {
        guard let url = request.URL else { return false }
        return url.absoluteString.containsString(self.baseUrl)
    }
    
}


// MARK: - URLRequestFilter<StringLiteralConvertible>

extension URLRequestFilter: StringLiteralConvertible {
    
    public init(stringLiteral value: String) {
        self.baseUrl = value
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.baseUrl = value
    }
    
    public init(unicodeScalarLiteral value: String) {
        self.baseUrl = value
    }

}

