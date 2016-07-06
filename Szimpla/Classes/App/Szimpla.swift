import Foundation
import Swifter
import SwiftyJSON

// MARK: - Szimpla

public struct Szimpla {
    
    // MARK: - Singleton
    
    public static var instance: Szimpla = Szimpla()
    
    
    // MARK: - Attributes
    
    internal let server: HttpServer
    
    
    // MARK: - Init
    
    internal init(server: HttpServer = HttpServer()) {
        self.server = server
    }
    
    
    // MARK: - Public
    
    public func sessionConfiguration(fromConfiguration configuration: NSURLSessionConfiguration) -> NSURLSessionConfiguration {
        configuration.protocolClasses = [SzimplaURLProtocol.self] as [AnyClass] + configuration.protocolClasses!
        return configuration
    }
    
    public func setup() {
        
        self.server["/start"] = { _ in
            SzimplaURLProtocol.start()
            return HttpResponse.OK(HttpResponseBody.Text(""))
        }
        self.server["/stop"] = { _ in
            let requests = SzimplaURLProtocol.stop()
            return HttpResponse.OK(HttpResponseBody.Json(requests as! AnyObject))
        }
        do {
            try server.start()
        }
        catch {
            print("SZIMPLA: Error launching the server, \(error)")
        }
    }
    
}
