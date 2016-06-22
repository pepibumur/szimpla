import Foundation
import SwiftyJSON

/**
 *  Model that represents a test snapshot
 */
internal struct Snapshot {
    
    // MARK: - Attributes
    
    /// Requests
    let requests: [Request]
}


// MARK: - Snapshot<Equatable>

extension Snapshot: Equatable {}

internal func == (lhs: Snapshot, rhs: Snapshot) -> Bool {
    return rhs.requests == lhs.requests
}
