import Foundation

internal class Saver<I, E: ErrorType> {
    
    func save(input: I) -> Result<Void, E> {
        assertionFailure("-save: must be overriden")
        return Result.Success(())
    }
    
}