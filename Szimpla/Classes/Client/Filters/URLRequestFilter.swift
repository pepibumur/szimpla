import Foundation

public struct URLRequestFilter: RequestFilter {
    
    // MARK: - Attributes
    
    private let baseUrl: String
    
    
    // MARK: - <RequestFilter>
    
    public func include(request request: Request) -> Bool {
        return request.url.containsString(self.baseUrl)
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

