import Foundation

/// Saves and retrieves data from the disk
internal class FileManager {
    
    // MARK: - Singleton
    
    /// Singletion instance
    internal static let instance: FileManager = try! FileManager()!
    
    
    // MARK: - Attributes
    
    /// Base path
    private let basePath: NSURL
    
    
    // MARK: - Init
    
    /**
     Initializes the FileManager
     
     - throws: Throws an error if the SZ_REFERENCE_DIR variable is not defined
     
     - returns: initialized FileManager
     */
    init?() throws {
        guard let basePathString = NSProcessInfo.processInfo().environment["SZ_REFERENCE_DIR"] else {
            throw FileManagerError.UndefinedReferenceDir
        }
        self.basePath = NSURL(fileURLWithPath: basePathString)
    }
    
    
    // MARK: - Internal
    
    /**
     Reads the data at the given path. If there's not data at that path, a nil object is returned.
     
     - parameter path: path where the data is.
     
     - returns: NSData if there's data at the given path.
     */
    internal func read(path path: String) -> NSData? {
        return NSData(contentsOfURL: self.basePath.URLByAppendingPathComponent(path))
    }
    
    /**
     Saves the given data at the provided path.
     
     - parameter data: data to be saved.
     - parameter path: path where the data should be saved.
     
     - throws: an exception if the data cannot be saved.
     */
    internal func save(data data: NSData, path: String) throws {
        try data.writeToURL(self.basePath.URLByAppendingPathComponent(path), options: NSDataWritingOptions.AtomicWrite)
    }
    
}


// MARK: - FileManager Errors

/**
 FileManager errors.
 
 - UndefinedReferenceDir: SZ_REFERENCE_DIR is not defined.
 */
internal enum FileManagerError: ErrorType {
    case UndefinedReferenceDir
}