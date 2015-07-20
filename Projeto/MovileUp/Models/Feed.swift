//
//  Feed.swift
//  MovileUp
//
//  Created by iOS on 7/20/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import Foundation


struct Feed {
    
    let feedUrl : String
    let title : String
    let link  : String
    let author: String?
    let description : String?
    let type : String
    let entries : [Entry]
    let responseDetails : String?
    let responseStatus  : Int?
    
    static func loadEntrys() -> [Entry]?{ //static func decode(j : AnyObject?) -> Entry? {
        
        let path: String = NSBundle.mainBundle().pathForResource("entry", ofType: "json")!
        
        if let data = NSData(contentsOfFile: path) ,
           let dict = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary,
           let responseData = dict["responseData"] as? NSDictionary,
           let feed = responseData["feed"] as? NSDictionary,
           let json = feed["entries"] as? [NSDictionary] {
            
            let e = json.map{ Entry.decode($0)}.filter{ $0 != nil}.map{ $0!}
            
            return e
        }
        
        return nil
    }
}