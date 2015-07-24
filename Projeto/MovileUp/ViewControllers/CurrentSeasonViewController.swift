//
//  CurrentSeasonViewController.swift
//  MovileUp
//
//  Created by iOS on 7/24/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import UIKit
import TraktModels
import Kingfisher

class CurrentSeasonViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var season: TraktModels.Season? = nil
    var year: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(season)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1}
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let iden = Reusable.CurrentSeason.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(iden, forIndexPath: indexPath) as! CurrentSeasonCell
        
        if let s = self.season {
            cell.loadSeason(s, year: 2015)
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "season_info" {
            //if let cell = sender as? CurrentSeasonCell {
                let vc = segue.destinationViewController as! ListEpisodesViewController
                vc.season = self.season
                //vc.year = self.year
            //}
        }
    }
}
