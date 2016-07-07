import Foundation

internal struct Logger {
    
    static func log(message: String) {
        print("SZIMPLA 🌴: \(message)")
    }
    
    static func logError(message: String) {
        print("SZIMPLA 🔴: \(message)")
    }
    
    static func logWarning(message: String) {
        print("SZIMPLA ⚠️: \(message)")
    }
    
}