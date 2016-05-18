import Foundation

public struct Szimpla {
    
    // MARK: - Singleton
    
    public static let instance: Szimpla = Szimpla()
    
    
    // MARK: - Public
    
    public func startRecording(name: String) {
        
    }
    
    public func stopRecording(name: String) -> Record {
        return Record(name: name)
    }
    
    public func match(
    
}