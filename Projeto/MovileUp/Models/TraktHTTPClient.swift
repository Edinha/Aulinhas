//
//  TraktHTTPClient.swift
//  MovileUp
//
//  Created by iOS on 7/22/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import Foundation
import Alamofire
import TraktModels
import Result

private enum Router: URLRequestConvertible {
    static let baseURLString = "https://api-v2launch.trakt.tv/"
    case Show(String)
    // MARK: URLRequestConvertible
    var URLRequest: NSURLRequest {
        let (path: String, parameters: [String: AnyObject]?, method: Alamofire.Method) = {
            switch self {
            case .Show(let id):
                return ("shows/\(id)", ["extended": "images,full"], .GET)
            }
        }()
    
    let URL = NSURL(string: Router.baseURLString)!
    let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
    URLRequest.HTTPMethod = method.rawValue
    let encoding = Alamofire.ParameterEncoding.URL
    return encoding.encode(URLRequest, parameters: parameters).0
    }
}

class TraktHTTPClient {
    private lazy var manager: Alamofire.Manager = {
        let configuration: NSURLSessionConfiguration = {
            var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            var headers = Alamofire.Manager.defaultHTTPHeaders
            headers["Accept-Encoding"] = "gzip"
            headers["Content-Type"] = "application/json"
            headers["trakt-api-version"] = "2"
            headers["trakt-api-key"] = "5824bf0d4a6de32bfd25f9024037a7da57347787cbc6944e260295676fa1b2d9"///colocar minha chave
            configuration.HTTPAdditionalHeaders = headers
            return configuration
        }()
        
        return Manager(configuration: configuration)
    }()
    
    func getShow(id: String, completion: ((Result<TraktModels.Show, NSError?>) -> Void)?) {
            
        let r = Router.Show(id)
                
        let m = manager.request(r.URLRequest).responseJSON{ _, _, j, error in

            if let json = j as? NSDictionary {
        
                if let show = TraktModels.Show.decode(json) {
                    completion?(Result<TraktModels.Show, NSError?>.success(show))
                } else {
                    completion?(Result.failure(error))
                }
            } else {
                completion?(Result.failure(error))
            }
        }

    }
}