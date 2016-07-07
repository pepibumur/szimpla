import Foundation
import NSURL_QueryDictionary
import Szimpla

private let configuration = Szimpla.Server.instance.sessionConfiguration(fromConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration())

internal func request(url url: String, parameters: [NSObject: AnyObject] = [:]) {
    let session = NSURLSession(configuration: configuration)
    let urlWithParameters = NSURL(string: url)!.uq_URLByAppendingQueryDictionary(parameters)
    session.dataTaskWithURL(urlWithParameters).resume()
}