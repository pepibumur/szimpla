import Foundation
import SwiftyJSON
import NSURL_QueryDictionary

// MARK: - SzimplaURLProtocol

internal class SzimplaURLProtocol: NSURLProtocol {
    
    // MARK: - Static
    
    private static  var requests: [JSON] = []
    
    internal class func start() {
        requests.removeAll()
    }
    
    internal class func stop() -> [JSON] {
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
    
    private static func dictionaryFromRequest(request: NSURLRequest) -> JSON {
        return self.body(fromRequest: request)
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
    
    private static func baseUrl(fromUrl url: NSURL) -> String {
        return url.baseURL?.absoluteString ?? ""
    }
    
}