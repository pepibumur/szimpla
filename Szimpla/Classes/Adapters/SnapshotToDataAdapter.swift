import Foundation
import SwiftyJSON

internal class SnapshotToDataAdapter: Adapter<Snapshot, NSData, SnapshotToDataError> {
    
    // MARK: - Adapter
    
    internal override func adapt(input: Snapshot) -> Result<NSData, SnapshotToDataError>! {
        let jsonArray = input.requests.map(self.requestToJson)
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(jsonArray, options: NSJSONWritingOptions.PrettyPrinted)
            return Result.Success(data)
        }
        catch {
            return Result.Error(.SerializationError(error))
        }
    }
    
    
    // MARK: - Private
    
    internal func requestToJson(request: Request) -> [NSObject: AnyObject] {
        var json: [String: AnyObject] = [:]
        json["url"] = request.url
        json["parameters"] = request.parameters
        json["body"] = request.body.dictionaryObject
        return json
    }
    
}


// MARK: - SnapshotToDataError

internal enum SnapshotToDataError: ErrorType {
    case SerializationError(ErrorType)
}