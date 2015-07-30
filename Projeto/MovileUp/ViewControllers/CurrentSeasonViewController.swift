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
    
    var seasons: [TraktModels.Season] = []
    var slug : String? = nil
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let s = self.slug {
            
            print(s)
            let http = TraktHTTPClient()
            http.getSeasons( s , completion: { [weak self] resultado in
                
                if let value = resultado.value {
                    self?.seasons = value
                }
            })
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1}
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let iden = "CurrentSeason"  //Reusable.CurrentSeason.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(iden, forIndexPath: indexPath) as! CurrentSeasonCell
        
        cell.loadSeason(seasons[indexPath.row])
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "season_info" {
            //if let cell = sender as? CurrentSeasonCell {
                let vc = segue.destinationViewController as! ListEpisodesViewController
                //vc.season = self.season
                //vc.year = self.year
            //}
        }
    }
}
