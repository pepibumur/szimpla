import Foundation
import SwiftyJSON

internal class RequestToSnapshotAdapter: Adapter<NSURLRequest, Snapshot, RequestToSnapshotError> {
    
    // MARK: - Adapter
    
    internal override func adapt(input: NSURLRequest) -> Result<Snapshot, RequestToSnapshotError >! {
        guard let url: NSURL = input.URL else {
            return Result.Error(.EmptyURL)
        }
        let headers: [String: String] = input.allHTTPHeaderFields ?? [:]
        let body: [String: AnyObject] = self.body(fromRequest: input)
        let parameters: [String: String] = self.parameters(fromUrl: url)
        return Result.Success(Snapshot(parameters: parameters, headers: headers, body: body))
    }
    
    
    // MARK: - Private
    
    private func body(fromRequest request: NSURLRequest) -> [String: AnyObject] {
        guard let data = request.HTTPBody else { return [:] }
        guard let json = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [String: AnyObject] else {
            return [:]
        }
        return json ?? [:]
    }
    
    private func parameters(fromUrl url: NSURL) -> [String: String] {
        let urlString = url.absoluteString
        //TODO
        return [:]
    }
    
}


// MARK: - DataToSnapshotError

internal enum RequestToSnapshotError: ErrorType {
    case EmptyURL
}

extension RequestToSnapshotError: Equatable {}

