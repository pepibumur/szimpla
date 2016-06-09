import Foundation

internal class FileManager {
    
    // MARK: - Singleton
    
    internal static let instance: FileManager = try! FileManager()!
    
    
    // MARK: - Attributes
    
    private let referenceDir: String
    
    
    // MARK: - Init
    
    internal init(referenceDir: String) {
        self.referenceDir = referenceDir
    }
    
    convenience init?() throws {
        guard let referenceDir = NSProcessInfo.processInfo().environment["SZ_REFERENCE_DIR"] else {
            throw FileManagerError.UndefinedReferenceDir
        }
        self.init(referenceDir: referenceDir)
    }
    
    
    // MARK: - Internal
    
    internal func read(withName name: String) -> NSData? {
        //TODO
        return nil
    }
    
    internal func save(snapshot snapshot: Snapshot, withName: String) -> Bool {
        //TODO
        return true
    }
    
}

internal enum FileManagerError: ErrorType {
    case UndefinedReferenceDir
}