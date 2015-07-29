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
    case Episode(String, Int, Int)
    case Episodes(String, Int)
    case PopularShows()
    case Seasons(String)
    case ShowPage(Int, Int)
    
    // MARK: URLRequestConvertible
    var URLRequest: NSURLRequest {
        let (path: String, parameters: [String: AnyObject]?, method: Alamofire.Method) = {
            switch self {
            case .Show(let id):
                return ("shows/\(id)", ["extended": "images,full"], .GET)
            case .Episode(let id, let season, let episode):
                return ("shows/\(id)/seasons/\(season)/episodes/\(episode)", ["extended": "images,full"], .GET)
            case .Episodes(let id, let season):
                return ("shows/\(id)/seasons/\(season)/episodes", ["extended": "images,full"], .GET)
            case .PopularShows():
                return ("shows/popular", ["extended": "images,full", "limit": "50"], .GET)
            case .Seasons(let id):
                return ("shows/\(id)/seasons", ["extended": "images,full"], .GET)
            case .ShowPage(let limit, let page):
                return ("shows/popular", ["extended": "images,full", "limit": "\(limit)", "page": "\(page)"], .GET)
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
    
    private func getJSONElement<T: JSONDecodable>(router: Router, completion: ((Result<T, NSError?>) -> Void)?) {
        manager.request(router).validate().responseJSON { (_, _, responseObject, error)  in
            
            if let json = responseObject as? NSDictionary {
                if let value = T.decode(json) {
                    completion?(Result.success(value))
                } else {
                    completion?(Result.failure(nil))
                }

            } else {
                completion?(Result.failure(error))
            }
        }
    }
    
    private func getJSONArray<T: JSONDecodable>(router: Router, completion: ((Result<[T], NSError?>) -> Void)?) {
        manager.request(router).validate().responseJSON { (_, _, responseObject, error)  in

            if let json = responseObject as? [NSDictionary] {    
                let values = json.map {T.decode($0)}.filter { $0 != nil }.map {$0!}
            
                completion?(Result.success(values))
            } else {
                completion?(Result.failure(error))
            }
        }
    }
            
    func getShow(id: String, completion: ((Result<TraktModels.Show, NSError?>) -> Void)?) {
        getJSONElement(Router.Show(id), completion: completion)
    }
        
    func getEpisode(showId: String, season: Int, episode: Int, completion: ((Result<TraktModels.Episode, NSError?>) -> Void)?) {
        getJSONElement(Router.Episode(showId, season, episode), completion: completion)
    }
    
    func getPopularShows(completion: ((Result<[TraktModels.Show], NSError?>) -> Void)?) {
        getJSONArray(Router.PopularShows(), completion: completion)
    }
    
    func getSeasons(showId: String, completion: ((Result<[TraktModels.Season], NSError?>) -> Void)?) {
        getJSONArray(Router.Seasons(showId), completion: completion)
    }
    
    func getEpisodes(showId: String, season: Int, completion: ((Result<[TraktModels.Episode], NSError?>) -> Void)?) {
        getJSONArray(Router.Episodes(showId, season), completion: completion)
    }
    
    func getShowsPage(limit: Int, page: Int, completion: ((Result<[TraktModels.Show], NSError?>) -> Void)?) {
        getJSONArray(Router.ShowPage(limit, page), completion: completion)
    }
};