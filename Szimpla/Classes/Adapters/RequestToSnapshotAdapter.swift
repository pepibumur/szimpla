import Foundation
import SwiftyJSON

internal class RequestToSnapshotAdapter: Adapter<NSURLRequest, Snapshot, RequestToSnapshotError> {
    
    // MARK: - Adapter
    
    internal override func adapt(input: NSURLRequest) -> Result<Snapshot, RequestToSnapshotError >! {

    }
    
}


// MARK: - DataToSnapshotError

internal enum RequestToSnapshotError: ErrorType {

}
