import Foundation

/// Saves an input element.
internal class Saver<I, E: ErrorType> {
    
    /**
     Saves an input element.
     
     - parameter input: Element to be saved.
     
     - returns: Saving result.
     */
    func save(input: I) -> Result<Void, E> {
        assertionFailure("-save: must be overriden")
        return Result.Success(())
    }
    
}