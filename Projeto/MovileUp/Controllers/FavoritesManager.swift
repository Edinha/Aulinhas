//
//  FavoritesManager.swift
//  MovileUp
//
//  Created by iOS on 7/28/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import Foundation

class FavoriteManager {
    
    var favoritesIdentifiers: Set<Int> = {
        let pers = NSUserDefaults.standardUserDefaults()
        
        let fav = pers.objectForKey("favorites") as? [Int]
        
        if let f = fav {
            let favorite: Set<Int> = Set(f)
            return favorite
        }
        
        return []
    }()
    
    func addIdentifier(identifier : Int) {
        favoritesIdentifiers.insert(identifier)
        save()
    }
    
    func removeIdentifier(identifier: Int) {
        favoritesIdentifiers.remove(identifier)
        save()
    }
    
    func save() {
        // acho q seria isso, mas esse codigo nao iria aqui :P
        let pers = NSUserDefaults.standardUserDefaults()
        var vet:[Int] = []
        
        for f in favoritesIdentifiers {
            vet.append(f)
        }
        
        pers.setObject(vet, forKey: "favorites")
        pers.synchronize()
    }
    
    func isFavorited(identifier: Int) -> Bool {
        return favoritesIdentifiers.contains(identifier)
    }
}