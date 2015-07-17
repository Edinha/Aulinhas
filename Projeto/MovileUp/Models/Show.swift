//
//  Show.swift
//  MovileUp
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import Foundation

struct Show {
    
    let url : String
    let name: String
    
    static func loadShow() -> [Show]{
        
        let s = [("poster", "Game of Thrones"), ("poster", "Breaking Bad"),
            ("poster", "Heart of Gold"), ("poster", "Dexter"),
            ("poster", "Arrow"), ("poster", "Daredevil")]
        
        
        return s.map{Show(url: $0.0, name: $0.1)}
    }
}