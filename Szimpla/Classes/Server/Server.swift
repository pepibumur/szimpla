import Foundation
import Swifter
import SwiftyJSON

// MARK: - Szimpla

public class Server {
    
    // MARK: - Singleton
    
    public static var instance: Server = Server()
    
    
    // MARK: - Attributes
    
    internal let server: HttpServer
    private var started: Bool
    
    
    // MARK: - Init
    
    internal init(server: HttpServer = HttpServer()) {
        self.server = server
        self.started = false
    }
    
    
    // MARK: - Public
    
    public func sessionConfiguration(fromConfiguration configuration: NSURLSessionConfiguration) -> NSURLSessionConfiguration {
        configuration.protocolClasses = [UrlProtocol.self] as [AnyClass] + configuration.protocolClasses!
        return configuration
    }
    
    public func tearUp() throws {
        if (self.started) {
            let error = ServerError.AlreadyRunning
            Logger.logError("Error launching the server, \(error)")
            throw error
        }
        Logger.log("Launching the server")
        self.server["/start"] = self.startRequest
        self.server["/stop"] = self.stopRequest
        do {
            try server.start()
            self.started = true
        }
        catch {
            Logger.logError("Error launching the server, \(error)")
            throw error
        }
    }
    
    public func tearDown() {
        Logger.log("Stopping the server")
        self.server.stop()
        self.started = false
    }
    
    
    // MARK: - Private
    
    private func startRequest(request: HttpRequest) -> HttpResponse {
        do {
            try UrlProtocol.start()
            return HttpResponse.OK(HttpResponseBody.Text(""))
        }
        catch {
            return HttpResponse.Forbidden
        }
    }
    
    private func stopRequest(request: HttpRequest) -> HttpResponse {
        let requests = UrlProtocol.stop()
        return HttpResponse.OK(HttpResponseBody.Json(requests as! AnyObject))
    }
    
}
