//
//  SeasonListViewController.swift
//  MovileUp
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import UIKit
import TraktModels

class SeasonListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet private var tableView: UITableView!
    
    var seasons: [TraktModels.Season] = []
    var id: Int? = nil
    let http = TraktHTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let i = self.id {

            http.getSeasons(String(i) , completion: { [weak self] resultado in
                if let value = resultado.value {
                    self?.seasons = value
                    self?.tableView.reloadData()
                }
            })
            
            for var indice = 0; i < seasons.count; indice++ {
                if seasons[indice].number == 0 {
                    seasons.removeAtIndex(indice)
                }
            }
            
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1}
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let iden = Reusable.Seasons.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(iden, forIndexPath: indexPath) as! CurrentSeasonCell
        
        cell.loadSeason(seasons[indexPath.row])
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "season_to_episodes" {
            if let cell = sender as? CurrentSeasonCell,
                indexPath = tableView.indexPathForCell(cell) {
                    
                    let s = seasons[indexPath.row]
                    let vc = segue.destinationViewController as! ListEpisodesViewController
                    vc.season = s
            }
        }
    }

    
}
