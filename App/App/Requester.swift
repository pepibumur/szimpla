import Foundation
import NSURL_QueryDictionary
import Szimpla

internal func request(url url: NSURL, parameters: [NSObject: AnyObject] = [:]) {
    let configuration = Szimpla.sessionConfiguration(fromConfiguration: NSURLSessionConfiguration.defaultSessionConfiguration())
    let session = NSURLSession(configuration: configuration)
    let urlWithParameters = url.uq_URLByAppendingQueryDictionary(parameters)
    session.dataTaskWithURL(urlWithParameters).resume()
}