import Foundation
import SwiftyJSON

internal class RequestsRemoteFetcher: Fetcher<[Request]> {
    
    // MARK: - Attributes
    
    private let baseUrl: String
    private let syncUrlDispatcher: SyncUrlRequestDispatcher
    
    
    // MARK: - Init
    
    internal init(baseUrl: String = "http://127.0.0.1:8080", syncUrlDispatcher: SyncUrlRequestDispatcher = SyncUrlRequestDispatcher()) {
        self.baseUrl = baseUrl
        self.syncUrlDispatcher = syncUrlDispatcher
    }
    
    
    // MARK: - Internal
    
    internal func tearUp() throws {
        let url = self.urlByAppendingPath("start")
        try self.syncUrlDispatcher.dispatch(url)
    }
    
    internal func tearDown(filter filter: RequestFilter! = nil) throws -> [Request]! {
        let url = self.urlByAppendingPath("stop")
        let data = try self.syncUrlDispatcher.dispatch(url)
        let requests = JSON(data: data).arrayValue.map(Request.init)
        return self.filtered(requests: requests, filter: filter)
    }
    

    // MARK: - Private
    
    private func urlByAppendingPath(path: String) -> String {
        return NSString(string: self.baseUrl).stringByAppendingPathComponent(path)
    }
    
    private func filtered(requests requests: [Request], filter: RequestFilter!) -> [Request] {
        return requests.filter { (request) -> Bool in
            if filter == nil { return true }
            return filter.include(request: request)
        }
    }
    
}