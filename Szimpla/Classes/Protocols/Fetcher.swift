import Foundation

internal class Fetcher<O, E: ErrorType> {
    
    func fetch() -> Result<O, E>! {
        assertionFailure("-fetch must be overriden")
        return nil
    }
    
}