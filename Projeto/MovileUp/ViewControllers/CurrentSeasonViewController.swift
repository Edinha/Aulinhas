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
    
    func loadSeason(img: NSURL, seasonNumber: Int, year: Int, count: Int) {
        //seasonImage.kf_setImageWithURL(img)
        //seasonStatus.text = "Season " + String(seasonNumber) + "(" + String(year) + ")"
        //episodeCount.text = String(count) + " episodes"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let s = self.season, y = self.year {
            
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1}
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let iden = Reusable.CurrentSeason.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(iden, forIndexPath: indexPath) as! CurrentSeasonCell
        
        //cell.loadEpisode(episodes[indexPath.row])
        
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
