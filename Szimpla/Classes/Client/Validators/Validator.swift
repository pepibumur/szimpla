import Foundation

public protocol Validator {

    func validate(recordedRequests recordedRequests: [Request], localRequests: [Request]) throws

}