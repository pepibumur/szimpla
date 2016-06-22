import Foundation
import Nimble

// MARK: - Constants

private let delaySeconds: Double = 0.5

/**
 Nimble Matcher that matches if after the execution of the closure, the expected requests have been sent.
 
 - parameter name:    Name of the snapshot to match against to.
 - parameter szimpla: Szimpla instance.
 
 - returns: Matcher function required by Nimble.
 */
public func matchRequests(name name: String, szimpla: Szimpla = Szimpla.instance) -> MatcherFunc<Any> {
    return MatcherFunc { actualExpression, failureMessage  in
        var error: ErrorType?
        do {
            try szimpla.start()
            try actualExpression.evaluate()
            blockThread(seconds: delaySeconds)
            try szimpla.validate(name)
        } catch let catchedError {
            error = catchedError
        }
        if let error = error {
            failureMessage.postfixMessage = "match \(name) snapshot. Validation error: \(error)"
        }
        return error != nil
    }
}

/**
 Nimble Matcher that records the sent requests during the execution of the closure.
 
 - parameter name:    Name of the snapshot where the requests will be saved.
 - parameter szimpla: Szimpla instance.
 
 - returns: Mathcer function required by Nimble
 */
public func recordRequests(name name: String, filter: RequestFilter! = nil, szimpla: Szimpla = Szimpla.instance) -> MatcherFunc<Any> {
    return MatcherFunc { actualExpression, failureMessage in
        var error: ErrorType?
        do {
            try szimpla.start()
            try actualExpression.evaluate()
            blockThread(seconds: delaySeconds)
            try szimpla.record(path: name, filter: filter)
        } catch let catchedError {
            error = catchedError
        }
        if let error = error {
            failureMessage.postfixMessage = "recording \(name) snapshot. Recording error: \(error)"
        }
        return error != nil
    }
}


// MARK: - Private

/**
 Blocks the current thread for X seconds
 
 - parameter seconds: Seconds of blocking.
 */
private func blockThread(seconds seconds: Double) {
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delaySeconds * Double(NSEC_PER_SEC)))
    let semaphore = dispatch_semaphore_create(0)
    dispatch_after(time, dispatch_get_main_queue(), {
        dispatch_semaphore_signal(semaphore)
    })
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
}