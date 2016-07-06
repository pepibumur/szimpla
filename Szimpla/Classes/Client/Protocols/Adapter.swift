import Foundation

/// Adapter protocol. Converts one input type into a different output type.
/// It returns an error if the adapter cannot adapt the input type.
internal class Adapter<I, O, E: ErrorType> {
    
    /**
     Adapts an input type into a different output type.
     
     - parameter input: Element to be adapted.
     
     - returns: Result object with the result.
     */
    func adapt(input: I) -> Result<O, E>! {
        assertionFailure("-adapt: method must be overriden")
        return nil
    }
    
}
