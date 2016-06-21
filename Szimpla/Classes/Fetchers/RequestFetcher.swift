import Foundation

internal class RequestFetcher {
    
    // MARK: - Attributes
    
    private let baseURL: NSURL?
    
    
    // MARK: - Init
    
    internal init(baseURL: NSURL? = nil) {
        self.baseURL = baseURL
    }
    
    
    // MARK: - Internal
    
    internal func tearUp() {
        URLRecordProtocol.tearUp()
    }
    
    
    internal func tearDown() -> [NSURLRequest] {
        let requests = URLRecordProtocol.tearDown()
        return filtered(requests: requests)
    }
    
    
    // MARK: - Private
    
    private func filtered(requests requests: [NSURLRequest]) -> [NSURLRequest] {
        return requests.filter { (request) -> Bool in
            let url = request.URL?.absoluteString ?? ""
            guard let baseURL = baseURL else { return true }
            return url.containsString(baseURL.absoluteString)
        }
    }
    
}