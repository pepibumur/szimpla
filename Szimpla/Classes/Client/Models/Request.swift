import Foundation
import SwiftyJSON

public struct Request {
    
    // MARK: - Attributes
    
    public let body: JSON
    public let url: String
    public let parameters: [String: String]
    
    
    // MARK: - Init
    
    internal init(body: JSON, url: String, parameters: [String: String]) {
        self.body = body
        self.url = url
        self.parameters = parameters
    }
    
    init(json: JSON) {
        self.url = json["url"].stringValue
        self.parameters = json["parameters"].dictionaryObject! as! [String: String]
        self.body = json["body"]
    }
    
    
    // MARK: - Internal
    
    internal func toDict() -> [NSObject: AnyObject] {
        var dict: [NSObject: AnyObject] = [:]
        dict["url"] = self.url
        dict["parameters"] = self.parameters
        dict["body"] = self.body.dictionaryObject
        return dict
    }
    
}


// MARK: - Request Extension (Equatable)

extension Request: Equatable {}

public func ==(lhs: Request, rhs: Request) -> Bool {
    return lhs.body == rhs.body &&
    lhs.url == rhs.url &&
    lhs.parameters == rhs.parameters
}