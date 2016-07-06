import Foundation

/// Fetches the recorded requests filtering them
internal class RequestFetcher {
    
    // MARK: - Internal
    
    /**
     Starts recording the requests.
     
     - throws: throws an error if it cannot start recording the requests.
     */
    internal func tearUp() throws {
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        session.dataTaskWithURL(NSURL(string: "http://127.0.0.1:8080/start")!).resume()
    }
    
    /**
     Stops recording and returns the requests filtering them.
     
     - parameter filter: filter for the requests.
     
     - returns: Filtered requests.
     */
    internal func tearDown(filter filter: RequestFilter! = nil) -> NSData! {
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        var data: NSData!
        let semaphore = dispatch_semaphore_create(0)
        session.dataTaskWithURL(NSURL(string: "http://127.0.0.1:8080/stop")!) { (_data, _, _) in
            data = _data
            dispatch_semaphore_signal(semaphore)
        }.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        return data
    }
    

    // MARK: - Private
    
    private func filtered(requests requests: [NSURLRequest], filter: RequestFilter!) -> [NSURLRequest] {
        return requests.filter { (request) -> Bool in
            if filter == nil { return true }
            return filter.include(request: request)
        }
    }
    
}