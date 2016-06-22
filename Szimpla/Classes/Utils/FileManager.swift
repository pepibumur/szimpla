import Foundation

/// Saves and retrieves data from the disk
internal class FileManager {
    
    // MARK: - Singleton
    
    /// Singletion instance
    internal static let instance: FileManager = try! FileManager.fromEnvironmentVar()
    
    
    // MARK: - Attributes
    
    /// Base path
    private let basePath: NSURL
    
    /// File Manager
    private let nsFileManager: NSFileManager
    
    
    // MARK: - Init
    
    /**
     Initializes the Szimpla file manager to be used from the provided base path.
     
     - parameter basePath: Base path to read the snapshots from.
     
     - returns: Initialized FileManager
     */
    internal init(basePath: NSURL, nsFileManager: NSFileManager = NSFileManager.defaultManager()) {
        self.basePath = basePath
        self.nsFileManager = nsFileManager
    }
    
    /**
     Initializes a Szimpla file manager using the user defined environment variable.
     
     - throws: Throws an FileManagerError if the directory hasn't been defined by the user.
     
     - returns: Initialized FileManager
     */
    private static func fromEnvironmentVar() throws -> FileManager {
        guard let basePathString = NSProcessInfo.processInfo().environment["SZ_REFERENCE_DIR"] else {
            throw FileManagerError.UndefinedReferenceDir
        }
        return FileManager(basePath: NSURL(fileURLWithPath: basePathString))
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
    
    /**
     Removes the data at the given path.
     
     - parameter path: path to remove the data from.
     
     - throws: an exception if the data cannot be removed.
     */
    internal func remove(path path: String) throws {
        try! self.nsFileManager.removeItemAtURL(self.basePath.URLByAppendingPathComponent(path))
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