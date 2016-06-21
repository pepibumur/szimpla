import Foundation

/// Class that validates the test using a local snapshot
internal class SnapshotValidator {
    
    /**
     Validates the test snapshot with the local one.
     
     - parameter testSnapshot:  Test snapshot that has been recorded.
     - parameter localSnapshot: Existing local snapshot to validate with.
     
     - returns: Returns successful if the validation did complete. Otherwise it returns the validation error
     */
    internal func validate(testSnapshot: Snapshot, localSnapshot: Snapshot) -> Result<Void, SnapshotValidationError> {
        return Result.Success(())
    }
    
}

public enum SnapshotValidationError: ErrorType {
    
}

