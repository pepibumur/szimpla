import Foundation
import SwiftyJSON
import NSURL_QueryDictionary

// MARK: - SzimplaURLProtocol

internal class SzimplaURLProtocol: NSURLProtocol {
    
    // MARK: - Static
    
    private static  var requests: [[String: AnyObject]] = []
    
    internal class func start() {
        requests.removeAll()
    }
    
    internal class func stop() -> [[String: AnyObject]] {
        let _requests = self.requests
        self.requests.removeAll()
        return _requests
    }
    
    
    // MARK: - NSURLProtocol
    
    override class func canInitWithRequest(request:NSURLRequest) -> Bool {
        self.requests.append(self.dictionaryFromRequest(request))
        return false
    }
    
    override class func canonicalRequestForRequest(request: NSURLRequest) -> NSURLRequest {
        return request
    }
    
    
    // MARK: - Private
    
    private static func dictionaryFromRequest(request: NSURLRequest) -> [String: AnyObject] {
        var dictionary: [String: AnyObject] = [:]
        dictionary["body"] = self.body(fromRequest: request).dictionaryObject ?? [:]
        dictionary["parameters"] = self.parameters(fromUrl: request.URL!)
        dictionary["url"] = request.URL?.absoluteString ?? ""
        return dictionary
    }
    
    private static func body(fromRequest request: NSURLRequest) -> JSON {
        guard let data = request.HTTPBody else { return [:] }
        guard let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [String: AnyObject] else {
            return [:]
        }
        return JSON(json ?? [:])
    }
    
    private static func parameters(fromUrl url: NSURL) -> [String: String] {
        return url.uq_queryDictionary() as? [String: String] ?? [:]
    }
    
}