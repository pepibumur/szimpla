import Foundation

internal class URLRecordProtocol: NSURLProtocol {
    
    // MARK: - Attributes
    
    private static var requests: [NSURLRequest] = []
    private static var registered: Bool = false
    
    
    // MARK: - Internal
    
    internal class func tearUp() {
        assert(!registered, "Request recording doesn't support concurrency")
        requests.removeAll()
        NSURLProtocol.registerClass(URLRecordProtocol)
    }
    
    internal class func tearDown() -> [NSURLRequest] {
        NSURLProtocol.unregisterClass(URLRecordProtocol)
        return requests
    }
    
    
    // MARK: - NSURLProtocol
    
    public override class func canInitWithRequest(request: NSURLRequest) -> Bool {
        requests.append(request)
        return false
    }
    
}