import Foundation

internal class Adapter<I, O, E: ErrorType> {
    
    func adapt(input: I) -> Result<O, E>! {
        assertionFailure("-adapt: method must be overriden")
        return nil
    }
    
}