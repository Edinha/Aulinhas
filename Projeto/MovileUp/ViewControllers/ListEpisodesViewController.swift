//
//  ListEpisodesViewController.swift
//  MovileUp
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import UIKit
import Result
import TraktModels

class ListEpisodesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var tableView: UITableView!
    
    let http = TraktHTTPClient()
    
    private var episodes:[TraktModels.Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        http.getEpisodes("game-of-thrones", season: 1,
            completion: { [weak self] resultado in
                if let e = resultado.value {
                    self?.episodes = e
                }
            })
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1}
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let iden = "Episode"//Reusable.Episode.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(iden, forIndexPath: indexPath) as! episodeTableCell
        
        cell.loadEpisode(episodes[indexPath.row])
  
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)

            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell!.backgroundColor = UIColor.blueColor()
            
            let title: String = String(episodes[indexPath.row].number)
            let text : String = episodes[indexPath.row].title!
            
            let alertController = UIAlertController(title: title, message: text, preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            
            presentViewController(alertController, animated: true, completion: nil)
            
    }
    
}
