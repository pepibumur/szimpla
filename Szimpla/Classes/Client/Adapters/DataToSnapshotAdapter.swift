import Foundation
import SwiftyJSON

/// Adapts NSData into Snapshot.
internal class DataToSnapshotAdapter: Adapter<NSData, Snapshot, DataToSnapshotError> {
    
    // MARK: - Adapter
    
    internal override func adapt(input: NSData) -> Result<Snapshot,DataToSnapshotError>! {
        let jsonRequests = JSON(data: input).arrayValue
        let requests = jsonRequests.map(self.request)
        return Result.Success(Snapshot(requests: requests))
    }
    
    
    // MARK: - Private
    
    private func request(fromJSON json: JSON) -> Request {
        let url = json["url"].stringValue
        let parameters = json["parameters"].dictionaryObject! as! [String: String]
        let body = json["body"]
        return Request(body: body, url: url, parameters: parameters)
    }
    
}