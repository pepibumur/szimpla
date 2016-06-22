import Foundation

/// Fetches the recorded requests filtering them
internal class RequestFetcher {
    
    // MARK: - Internal
    
    /**
     Starts recording the requests.
     
     - throws: throws an error if it cannot start recording the requests.
     */
    internal func tearUp() throws {
        try URLRecordProtocol.tearUp()
    }
    
    /**
     Stops recording and returns the requests filtering them.
     
     - parameter filter: filter for the requests.
     
     - returns: Filtered requests.
     */
    internal func tearDown(filter filter: RequestFilter! = nil) -> [NSURLRequest] {
        let requests = URLRecordProtocol.tearDown()
        return self.filtered(requests: requests, filter: filter)
    }
    
    
    // MARK: - Private
    
    private func filtered(requests requests: [NSURLRequest], filter: RequestFilter!) -> [NSURLRequest] {
        return requests.filter { (request) -> Bool in
            if filter == nil { return true }
            return filter.include(request: request)
        }
    }
    
}