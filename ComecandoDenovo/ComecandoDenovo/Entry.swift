//
//  Entry.swift
//  ComecandoDenovo
//
//  Created by iOS on 7/21/15.
//  Copyright (c) 2015 iOS. All rights reserved.
//

import Foundation

struct Entry {
    
    let title : String
    let link  : NSURL
    let author : String?
    let publishedDate : NSDate
    let contentSnippet: String
    let content : String
    let categories : [String]?
    
    static func decode(j : AnyObject?) -> Entry? {
        
        if let dic = j as? NSDictionary {
            
            let dateString = dic["publishedDate"] as! String
            let dateFormatter =  NSDateFormatter()
            dateFormatter.dateFormat = "EEE, d MM yyyy HH:mm::ss Z"
            let date = dateFormatter.dateFromString(dateString)
            
            let t = dic["title"] as! String
            let l = NSURL(string: (dic["link"] as? String)!)
            
            let cSnippet = dic["contentSnippet"] as! String
            let c = dic["content"] as! String
            
            let entry = Entry(title:t,  link: l!, author: nil, publishedDate: date!, contentSnippet: cSnippet, content: c, categories : nil)
            
            return entry
        }
        
        return nil
    }
    
    static func loadEntrys() -> [Entry]?{
        
        let path: String = NSBundle.mainBundle().pathForResource("entry", ofType: "json")!
        
        if let data = NSData(contentsOfFile: path) ,
            let dict = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary,
            let responseData = dict["responseData"] as? NSDictionary,
            let feed = responseData["feed"] as? NSDictionary,
            let json = feed["entries"] as? [NSDictionary] {
                
                let e = json.map{ Entry.decode($0)}.filter{ $0 != nil}.map{ $0!}
                // [Entry?]?                [Entry?]       [Entry]
                
                return e
        }
        
        return nil
    }
}