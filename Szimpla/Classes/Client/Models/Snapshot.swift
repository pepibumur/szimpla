import Foundation
import SwiftyJSON

/**
 *  Model that represents a test snapshot
 */
public struct Snapshot {
    
    // MARK: - Attributes
    
    /// Requests
    public let requests: [Request]
}


// MARK: - Snapshot<Equatable>

extension Snapshot: Equatable {}

public func == (lhs: Snapshot, rhs: Snapshot) -> Bool {
    return rhs.requests == lhs.requests
}
