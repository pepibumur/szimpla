import Foundation
import SwiftyJSON

internal class RequestsLocalFetcher: Fetcher<[Request]> {
    
    // MARK: - Attributes
    
    private let path: String
    private let fileManager: FileManager
    
    
    // MARK: - Init
    
    internal init(path: String, fileManager: FileManager = FileManager.instance) {
        self.path = path
        self.fileManager = fileManager
    }
    
    internal static func withPath(path: String) -> RequestsLocalFetcher {
        return RequestsLocalFetcher(path: path)
    }
    
    
    // MARK: - Fetcher
    
    override func fetch() throws -> [Request]! {
        guard let data = self.fileManager.read(path: self.path) else {
            throw SnapshotFetcherError.NotFound(path)
        }
        return JSON(data: data).arrayValue.map(Request.init)
    }

}
