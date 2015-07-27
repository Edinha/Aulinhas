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
    @IBOutlet private weak var frontImage: UIImageView!
    @IBOutlet private weak var backImage: UIImageView!
    @IBOutlet private weak var year: UILabel!
    
    let http = TraktHTTPClient()
    
    private var episodes:[TraktModels.Episode] = []
    
    var season: TraktModels.Season? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let s = self.season {
            self.title = "Season " + String(s.number)
            
            if let img = s.thumbImageURL {
                self.backImage.kf_setImageWithURL(img)
            }

            print(s.identifiers!.slug)
            http.getEpisodes(String(s.identifiers!.trakt), season: s.number,
                completion: { [weak self] r in
                    if let e = r.value {
                        self?.episodes = e
                        self?.year.text = "Season " + String(s.number)
                        
                       self?.tableView.reloadData()
                    }
                    
                })
            
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1}
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let iden = Reusable.Episode.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(iden, forIndexPath: indexPath) as! episodeTableCell
        
        cell.loadEpisode(episodes[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)

            /*let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell!.backgroundColor = UIColor.blueColor()
            
            let title: String = String(episodes[indexPath.row].number)
            let text : String = episodes[indexPath.row].title!
            
            let alertController = UIAlertController(title: title, message: text, preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            
            presentViewController(alertController, animated: true, completion: nil) */
            
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "episodes_to_episode" {
            if let cell = sender as? episodeTableCell,
                indexPath = tableView.indexPathForCell(cell) {
                
                    let e = episodes[indexPath.row]
                    let vc = segue.destinationViewController as! EpisodeViewController
                    vc.episode = e
                    
            }
        }
    }
}
