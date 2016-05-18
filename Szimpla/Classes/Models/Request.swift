import Foundation
import SwiftyJSON

struct Request {
    
    // MARK: - Attributes
    
    let headers: [String: Value]
    let url: String
    let body: JSON
    
}