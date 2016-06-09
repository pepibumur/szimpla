import Foundation
import SwiftyJSON

internal class DataToSnapshotAdapter: Adapter<NSData, Snapshot, DataToSnapshotError> {
    
    // MARK: - Adapter
    
    internal override func adapt(input: NSData) -> Result<Snapshot,DataToSnapshotError>! {
        let json = JSON(data: input)
        guard let parameters: [String: String] = json["parameters"].dictionaryObject as? [String: String] else { return Result.Error(.WrongFormat("Missing parameters")) }
        guard let headers: [String: String] = json["headers"].dictionaryObject as? [String: String] else { return Result.Error(.WrongFormat("Missing headers")) }
        guard let body: [String: AnyObject] = json["body"].dictionaryObject else { return Result.Error(.WrongFormat("Missing body")) }
        return .Success(Snapshot(parameters: parameters, headers: headers, body: body))
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