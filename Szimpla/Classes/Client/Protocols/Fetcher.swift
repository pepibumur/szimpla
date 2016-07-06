import Foundation

/// Fetches and returns the element fetched.
internal class Fetcher<O, E: ErrorType> {
    
    /**
     Fetches something from a source and returns it.
     
     - returns: Result with the fetched element or an error.
     */
    func fetch() -> Result<O, E>! {
        assertionFailure("-fetch must be overriden")
        return nil
    }
    
}
