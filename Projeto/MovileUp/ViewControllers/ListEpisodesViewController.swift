//
//  ListEpisodesViewController.swift
//  MovileUp
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import UIKit

class ListEpisodesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet private weak var tableView: UITableView!
    
    let episodes = Episode.all()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1}
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let iden = Reusable.Episode.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(iden, forIndexPath: indexPath) as! episodeTableCell
        
        cell.loadEpisode(episodes[indexPath.row])
  
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)

            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell!.backgroundColor = UIColor.blueColor()
            
            let title: String = episodes[indexPath.row].episode
            let text : String = episodes[indexPath.row].name
            
            let alertController = UIAlertController(title: title, message: text, preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            
            presentViewController(alertController, animated: true, completion: nil)
            
    }
    
}
