import Foundation
import SwiftyJSON

public struct DefaultValidator: Validator {
    
    // MARK: - <Validator>DefaultValidator
    
    public func validate(recordedRequests recordedRequests: [Request], localRequests: [Request]) throws {
        try self.validateRequestsCount(recordedRequests: recordedRequests, localRequests: localRequests)
        for i in 0..<recordedRequests.count {
            let recordedRequest = recordedRequests[i]
            let localRequest = localRequests[i]
            try self.validateRequest(recordedRequest: recordedRequest, localRequest: localRequest)
        }
    }
    
    
    // MARK: - Private
    
    private func validateRequestsCount(recordedRequests recordedRequests: [Request], localRequests: [Request]) throws {
        if recordedRequests.count != localRequests.count {
            throw SnapshotValidationError.InvalidCount(expected: recordedRequests.count, got: localRequests.count)
        }
    }
    
    private func validateRequest(recordedRequest recordedRequest: Request, localRequest: Request) throws {
        try self.validateParameters(recordedParameters: recordedRequest.parameters, localParameters: localRequest.parameters)
        try self.validateJSON(recordedJSON: recordedRequest.body, localJSON: localRequest.body)
    }

    private func validateParameters(recordedParameters recordedParameters: [String: String], localParameters: [String: String]) throws {
        for localParameter in localParameters.keys {
            let localValue = localParameters[localParameter]!
            guard let recordedValue = recordedParameters[localParameter] else { continue }
            try self.match(key: localValue, regexString: localValue, withString: recordedValue)
        }
    }
    
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
    
    private func validateString(key key: String, recordedJSON recordedJSON: JSON, localJSON localJSON: JSON)throws {
        guard let recordedString = recordedJSON.string else {
            throw SnapshotValidationError.InvalidType(key: key, expected: "\(localJSON.type)", got: "\(recordedJSON.type)")
        }
        let localString = localJSON.stringValue
        try self.match(key: key, regexString: localString, withString: recordedString)
    }
    
    private func validateNumber(key key: String, recordedJSON recordedJSON: JSON, localJSON localJSON: JSON)throws {
        guard let recordedNumber = recordedJSON.number else {
            throw SnapshotValidationError.InvalidType(key: key, expected: "\(localJSON.type)", got: "\(recordedJSON.type)")
        }
        let localNumber = localJSON.numberValue
        if !recordedNumber.isEqualToNumber(localNumber) {
            throw SnapshotValidationError.InvalidValue(key: key, expected: "\(localNumber)", got: "\(recordedNumber)")
        }
    }
    
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

    private func match(key key: String, regexString: String, withString string: String) throws {
        if !string.containsString(regexString) {
            throw SnapshotValidationError.InvalidValue(key: key, expected: regexString, got: string)
        }
    }
    
}

