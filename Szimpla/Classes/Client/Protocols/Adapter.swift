import Foundation

internal class Adapter<I, O, E: ErrorType> {

    func adapt(input: I) -> O! {
        assertionFailure("-adapt: method must be overriden")
        return nil
    }
    
}
