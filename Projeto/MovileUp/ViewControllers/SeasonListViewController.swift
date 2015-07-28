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
    var id: String? = nil
    let http = TraktHTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let slug = self.id {

            http.getSeasons(slug , completion: { [weak self] resultado in
                if let value = resultado.value {
                    self?.seasons = value

                    for var indice = 0; indice < self?.seasons.count; indice++ {
                        if self?.seasons[indice].number == 0 {
                            self?.seasons.removeAtIndex(indice)
                        }
                    }
                    
                    sort(&self!.seasons, { a, b in
                        return a.number > b.number
                    })
                    
                    self?.tableView.reloadData()
                }
            })
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
                    vc.id = self.id
                    vc.number = s.number
                    vc.season = s
            }
        }
    }

    
}
