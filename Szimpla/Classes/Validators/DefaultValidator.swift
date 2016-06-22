import Foundation
import SwiftyJSON

/**
 *  DefaultValidator that validates:
 *  - If the number of requests if the same
 *  - If the provided local data match the remote one for each request.
 *
 *  It doesn't validate:
 *  - If there's an extra attribute in the recorded requests.
 */
public struct DefaultValidator: Validator {
    
    // MARK: - <Validator>DefaultValidator
    
    public func validate(recordedSnapshot recordedSnapshot: Snapshot, localSnapshot: Snapshot) throws {
        try self.validateRequestsCount(recordedSnapshot: recordedSnapshot, localSnapshot: localSnapshot)
        for i in 0..<recordedSnapshot.requests.count {
            let recordedRequest = recordedSnapshot.requests[i]
            let localRequest = localSnapshot.requests[i]
            try self.validateRequest(recordedRequest: recordedRequest, localRequest: localRequest)
        }
    }
    
    
    // MARK: - Private
    
    /**
     Validates if the number of requests if the same for both Snapshots, the recorded one and the one loca.
     
     - parameter recordedSnapshot: Recorded Snapshot.
     - parameter localSnapshot:    Local Snapshot.
     
     - throws: Throws an SnapshotValidationError.InvalidCount error if the count is not the same
     */
    private func validateRequestsCount(recordedSnapshot recordedSnapshot: Snapshot, localSnapshot: Snapshot) throws {
        if recordedSnapshot.requests.count != localSnapshot.requests.count {
            throw SnapshotValidationError.InvalidCount(expected: localSnapshot.requests.count, got: recordedSnapshot.requests.count)
        }
    }
    
    /**
     Validates the recorded request matches the local one.
     
     - parameter recordedRequest: Recorded Request.
     - parameter localRequest:    Local Request.
     
     - throws: Throws an error if the request do not match.
     */
    private func validateRequest(recordedRequest recordedRequest: Request, localRequest: Request) throws {
        try self.validateParameters(recordedParameters: recordedRequest.parameters, localParameters: localRequest.parameters)
        try self.validateJSON(recordedJSON: recordedRequest.body, localJSON: localRequest.body)
    }
    
    /**
     Validates if the recorded parameters match the local ones.
     
     - parameter recordedParameters: Recorded parameters.
     - parameter localParameters:    Local parameters.
     
     - throws: Throws an error if the parameters do not match.
     */
    private func validateParameters(recordedParameters recordedParameters: [String: String], localParameters: [String: String]) throws {
        for localParameter in localParameters.keys {
            let localValue = localParameters[localParameter]!
            guard let recordedValue = recordedParameters[localParameter] else { continue }
            try self.match(key: localValue, regexString: localValue, withString: recordedValue)
        }
    }
    
    /**
     Validates if the recorded body matches the local body
     
     - parameter recordedJSON: Recorded JSON.
     - parameter localJSON:    Local JSON.
     
     - throws: Throws an error if the bodies aret not the same.
     */
    private func validateJSON(recordedJSON recordedJSON: JSON, localJSON localJSON: JSON) throws {
        for element in localJSON {
            let key = element.0
            let localElementJson = element.1
            let recordedElementJson = recordedJSON[key]
            if recordedElementJson == JSON.null {
                throw SnapshotValidationError.NotFound(key: key)
            }
            // JSON
            if let localElementdictionary = localElementJson.dictionary {
                try self.validateJSON(recordedJSON: recordedElementJson, localJSON: localElementJson)
            }
            // ARRAY
            else if let localElementArray = localElementJson.array {
                try self.validateArray(key: key, recordedJSON: localElementJson, localJSON: localElementJson)
            }
            // STRING
            else if let localElementString = localElementJson.string {
                try self.validateString(key: key, recordedJSON: recordedElementJson, localJSON: localElementJson)
            }
            // NUMBER
            else if let localElementNumber = localElementJson.number {
                try self.validateNumber(key: key, recordedJSON: recordedElementJson, localJSON: localElementJson)
            }
        }
    }
    
    /**
     Validates if the recorded string matches the local one.
     
     - parameter key:          Key that identifies the values in the parent.
     - parameter recordedJSON: Recorded JSON string.
     - parameter localJSON:    Local JSON string.
     
     - throws: Throws a SnapshotValidationError if they don't match.
     */
    private func validateString(key key: String, recordedJSON recordedJSON: JSON, localJSON localJSON: JSON)throws {
        guard let recordedString = recordedJSON.string else {
            throw SnapshotValidationError.InvalidType(key: key, expected: "\(localJSON.type)", got: "\(recordedJSON.type)")
        }
        let localString = localJSON.stringValue
        try self.match(key: key, regexString: localString, withString: recordedString)
    }
    
    /**
     Validates if the recorded number matches the local one.
     
     - parameter key:          Key that identifies the values in the parent.
     - parameter recordedJSON: Recorded JSON number.
     - parameter localJSON:    Local JSON number.
     
     - throws: Throws a SnapshotValidationError if they don't match.
     */
    private func validateNumber(key key: String, recordedJSON recordedJSON: JSON, localJSON localJSON: JSON)throws {
        guard let recordedNumber = recordedJSON.number else {
            throw SnapshotValidationError.InvalidType(key: key, expected: "\(localJSON.type)", got: "\(recordedJSON.type)")
        }
        let localNumber = localJSON.numberValue
        if !recordedNumber.isEqualToNumber(localNumber) {
            throw SnapshotValidationError.InvalidValue(key: key, expected: "\(localNumber)", got: "\(recordedNumber)")
        }
    }
    
    /**
     Validates if the recorded array matches the local one.
     
     - parameter key:          Key that identifies the values in the parent.
     - parameter recordedJSON: Recorded JSON array.
     - parameter localJSON:    Local JSON array.
     
     - throws: Throws a SnapshotValidationError if they don't match.
     */
    private func validateArray(key key: String, recordedJSON recordedJSON: JSON, localJSON localJSON: JSON)throws {
        guard let recordedArray = recordedJSON.array else {
            throw SnapshotValidationError.InvalidType(key: key, expected: "\(localJSON.type)", got: "\(recordedJSON.type)")
        }
        let localArray = localJSON.arrayValue
        for i in 0..<localArray.count {
            let localElementJson = localArray[i]
            let recordedElementJson = recordedArray[i]
            try self.validateJSON(recordedJSON: recordedElementJson, localJSON: localElementJson)
        }
    }
    
    /**
     Checks if the regex expression matches the provided string.
     
     - parameter key: Key that identifies the values in the parent.
     - parameter regexString: Regular Expression
     - parameter string:      String to match.
     
     - throws: Throws an error if it doesn't match.
     */
    private func match(key key: String, regexString: String, withString string: String) throws {
        if !string.containsString(regexString) {
            throw SnapshotValidationError.InvalidValue(key: key, expected: regexString, got: string)
        }
    }
}

