import Foundation

internal class URLRecordProtocol: NSURLProtocol {
    
    // MARK: - Attributes
    
    /**
     List of recorded requests
     */
    internal static var requests: [NSURLRequest] = []
    
    /**
     Returns true if the protocol is already registered.
     */
    internal static var registered: Bool = false
    
    
    // MARK: - Internal
    
    /**
     Starts recording any sent request.
     
     - throws: throws an URLRecordProtocolError if this method gets called when it's already recording.
     */
    internal class func tearUp() throws {
        if registered {
            throw URLRecordProtocolError.AlreadyRegistered
            return
        }
        requests.removeAll()
        NSURLProtocol.registerClass(URLRecordProtocol)
        URLRecordProtocol.registered = true
    }
    
    /**
     Stops recording requests.
     
     - returns: All registered requests.
     */
    internal class func tearDown() -> [NSURLRequest] {
        NSURLProtocol.unregisterClass(URLRecordProtocol)
        URLRecordProtocol.registered = false
        var copiedRequests = self.requests
        self.requests.removeAll()
        return copiedRequests
    }
    
    
    // MARK: - NSURLProtocol
    
    public override class func canInitWithRequest(request: NSURLRequest) -> Bool {
        requests.append(request)
        return false
    }
    
}


/**
 URLRecordProtocol Errors
 
 - AlreadyRegistered: Returned when someones tries to register the protocol when it's already registered.
 */
internal enum URLRecordProtocolError: ErrorType {
    case AlreadyRegistered
}