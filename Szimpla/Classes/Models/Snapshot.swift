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