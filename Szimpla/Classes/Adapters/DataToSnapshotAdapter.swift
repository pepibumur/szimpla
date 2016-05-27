import Foundation
import SwiftyJSON

internal class DataToSnapshotAdapter: Adapter<NSData, Snapshot, DataToSnapshotError> {
    
    // MARK: - Adapter
    
    internal override func adapt(input: NSData) -> Result<Snapshot,DataToSnapshotError >! {
        let json = JSON(data: input)
        guard let parameters: [String: String] = json["parameters"].dictionaryObject as? [String: String] else { return Result.Error(.WrongFormat("Missing parameters")) }
        guard let headers: [String: String] = json["headers"].dictionaryObject as? [String: String] else { return Result.Error(.WrongFormat("Missing headers")) }
        guard let body: [String: AnyObject] = json["parameters"].dictionaryObject else { return Result.Error(.WrongFormat("Missing body")) }
        return .Success(Snapshot(parameters: parameters, headers: headers, body: body))
    }
    
}


// MARK: - DataToSnapshotError

internal enum DataToSnapshotError: ErrorType {
    case WrongFormat(String)
}
