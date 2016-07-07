import Foundation

/// Saves and retrieves data from the disk
internal class FileManager {
    
    // MARK: - Singleton
    
    internal static let instance: FileManager = try! FileManager.fromEnvironmentVar()
    
    
    // MARK: - Attributes
    
    private let basePath: String
    private let nsFileManager: NSFileManager
    
    
    // MARK: - Init
    
    internal init(basePath: String, nsFileManager: NSFileManager = NSFileManager.defaultManager()) {
        self.basePath = basePath
        self.nsFileManager = nsFileManager
    }
    
    private static func fromEnvironmentVar() throws -> FileManager {
        guard let basePathString = NSProcessInfo.processInfo().environment["SZ_REFERENCE_DIR"] else {
            throw FileManagerError.UndefinedReferenceDir
        }
        return FileManager(basePath: basePathString)
    }
    
    
    // MARK: - Internal
    
    internal func read(path path: String) -> NSData? {
        return NSData(contentsOfFile: NSString(string: self.basePath).stringByAppendingPathComponent(path))
    }
    
    internal func save(data data: NSData, path: String) throws {
        let destinationPath = NSString(string: self.basePath).stringByAppendingPathComponent(path)
        let destinationFolderPath = NSString(string: destinationPath).stringByDeletingLastPathComponent
        if !nsFileManager.fileExistsAtPath(destinationFolderPath) {
            _ = try? nsFileManager.createDirectoryAtPath(destinationFolderPath, withIntermediateDirectories: true, attributes: nil)
        }
        try data.writeToFile(destinationPath, options: NSDataWritingOptions.AtomicWrite)
    }

    internal func remove(path path: String) throws {
        let destinationPath = NSString(string: self.basePath).stringByAppendingPathComponent(path)
        try! self.nsFileManager.removeItemAtPath(destinationPath)
    }
}
