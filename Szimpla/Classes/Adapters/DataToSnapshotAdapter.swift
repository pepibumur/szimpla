import Foundation

internal class DataToSnapshotAdapter: Adapter<NSData, Snapshot, DataToSnapshotError> {
    
    override func adapt(input: NSData) -> Result<Snapshot,DataToSnapshotError >! {
        return .Error(.WrongFormat)
    }
    
}


// MARK: - DataToSnapshotError

internal enum DataToSnapshotError: ErrorType {
    case WrongFormat
}
