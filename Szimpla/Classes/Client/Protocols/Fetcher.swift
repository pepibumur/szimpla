import Foundation

internal class Fetcher<O> {
    
    func fetch() throws -> O! {
        assertionFailure("-fetch must be overriden")
        return nil
    }
    
}
