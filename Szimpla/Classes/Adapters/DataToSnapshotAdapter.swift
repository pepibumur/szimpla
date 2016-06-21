import Foundation
import SwiftyJSON

internal class DataToSnapshotAdapter: Adapter<NSData, Snapshot, DataToSnapshotError> {
    
    // MARK: - Adapter
    
    internal override func adapt(input: NSData) -> Result<Snapshot,DataToSnapshotError>! {
        let json = JSON(data: input)
        let jsonRequests = json["requests"].arrayValue
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


// MARK: - DataToSnapshotError

public enum DataToSnapshotError: ErrorType {
    case WrongFormat(String)
}

extension DataToSnapshotError: Equatable {}

public func ==(lhs: DataToSnapshotError, rhs: DataToSnapshotError) -> Bool {
    switch lhs {
    case .WrongFormat(let lhsWrongFormatMessage):
        switch rhs {
        case .WrongFormat(let rhsWrongFormatMessage): return lhsWrongFormatMessage == rhsWrongFormatMessage
        default: return false
        }
    default:
        false
    }
}