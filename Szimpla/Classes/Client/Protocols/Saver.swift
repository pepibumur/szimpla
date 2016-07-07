import Foundation

internal class Saver<I> {
    
    func save(input: I) throws -> Void {
        assertionFailure("-save: must be overriden")
        return ()
    }
    
}