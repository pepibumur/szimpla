import Foundation

public protocol RequestFilter {
    
    func include(request request: Request) -> Bool
    
}