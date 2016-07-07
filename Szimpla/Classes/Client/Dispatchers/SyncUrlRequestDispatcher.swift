import Foundation

internal class SyncUrlRequestDispatcher {
    
    internal func dispatch(url: String) throws -> NSData {
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration)
        var data: NSData!
        var error: NSError!
        let semaphore = dispatch_semaphore_create(0)
        session.dataTaskWithURL(NSURL(string: url)!) { (_data, _, _error) in
            data = _data
            error = _error
            dispatch_semaphore_signal(semaphore)
            }.resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        if let error = error {
            throw error
        }
        else {
            return data
        }
    }
    
}