import Foundation

/**
 *  Protocols that defines a Validator. A validator is an object that takes the recorded Snapshot and the existing snapshot and validates it throwing an error if the validation fails.
 */
public protocol Validator {

    /**
     Validates Snapshots.
     
     - parameter recordedSnapshot: Recorded Snapshot to be validated.
     - parameter localSnapshot:    Existing Snapshot previously created.
     
     - throws: Thrown error if the validation fails
     */
    func validate(recordedSnapshot recordedSnapshot: Snapshot, localSnapshot: Snapshot) throws
}