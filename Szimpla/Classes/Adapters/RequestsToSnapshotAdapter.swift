import Foundation
import SwiftyJSON
import NSURL_QueryDictionary

internal class RequestsToSnapshotAdapter: Adapter<[NSURLRequest], Snapshot, RequestsToSnapshotError> {
    
    // MARK: - Adapter
    
    internal override func adapt(input: [NSURLRequest]) -> Result<Snapshot, RequestsToSnapshotError>! {
        let requestsResults = input.map(self.request)
        let requests: [Request] = requestsResults.filter({$0.value != nil}).map({$0.value})
        let errors: [RequestsToSnapshotError] = requestsResults.filter({$0.error != nil}).map({$0.error})
        if errors.count != 0 {
        }
        return Result.Success(Snapshot(requests: requests))
    }
    
    
    // MARK: - Private
    
    private func request(fromURLRequest urlRequest: NSURLRequest) -> Result<Request, RequestsToSnapshotError>! {
        guard let url = urlRequest.URL else {
            return Result.Error(.EmptyURL)
        }
        let body = self.body(fromRequest: urlRequest)
        let parameters = self.parameters(fromUrl: url)
        let baseUrl = self.baseUrl(fromUrl: url)
        return Result.Success(Request(body: body, url: baseUrl, parameters: parameters))
    }
    
    private func body(fromRequest request: NSURLRequest) -> JSON {
        guard let data = request.HTTPBody else { return [:] }
        guard let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [String: AnyObject] else {
            return [:]
        }
        return JSON(json ?? [:])
    }
    
    private func parameters(fromUrl url: NSURL) -> [String: String] {
        return url.uq_queryDictionary() as? [String: String] ?? [:]
    }
    
    private func baseUrl(fromUrl url: NSURL) -> String {
        return url.baseURL?.absoluteString ?? ""
    }
}


// MARK: - DataToSnapshotError

internal enum RequestsToSnapshotError: ErrorType {
    case EmptyURL
}

extension RequestsToSnapshotError: Equatable {}

