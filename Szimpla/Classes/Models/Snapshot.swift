import Foundation
import SwiftyJSON

internal struct Snapshot {
    
    // MARK: - Attributes
    
    internal let parameters: [String: String]
    internal let headers: [String: String]
    internal let body: [String: AnyObject]
    
    
    // MARK: - Init
    
    internal init(parameters: [String: String], headers: [String: String], body: [String: AnyObject]) {
        self.parameters = parameters
        self.headers = headers
        self.body = body
    }
    
}

extension Snapshot: Equatable {}

internal func == (lhs: Snapshot, rhs: Snapshot) -> Bool {
    let sameHeaders: Bool =  lhs.headers == rhs.headers
    let sameParameters: Bool = lhs.parameters == rhs.parameters
    let lhsBody: JSON = JSON(lhs.body)
    let rhsBody: JSON = JSON(rhs.body)
    let sameBody: Bool = lhsBody == rhsBody
    return sameHeaders && sameParameters && sameBody
}
