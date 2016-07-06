import Foundation
import NSURL_QueryDictionary

internal func request(url url: NSURL, parameters: [NSObject: AnyObject] = [:]) {
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    let urlWithParameters = url.uq_URLByAppendingQueryDictionary(parameters)
    session.dataTaskWithURL(urlWithParameters).resume()
}