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
import Kingfisher
import FloatRatingView

class ListEpisodesViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var frontImage: UIImageView!
    @IBOutlet private weak var backImage: UIImageView!
    @IBOutlet private weak var year: UILabel!
    
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var rating: FloatRatingView!
    
    let http = TraktHTTPClient()
    private var episodes:[TraktModels.Episode] = []
    var season:TraktModels.Season? = nil
    
    var id: String? = nil
    var number: Int? = nil
    //var img: NSURL? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let s = self.season, img = s.thumbImageURL {
            self.frontImage.kf_setImageWithURL(img)
            self.backImage.kf_setImageWithURL(img)
            self.rating.rating = s.rating!
            self.ratingLabel.text = String(format: "%.1f", s.rating!)
        }
        
        if let id = self.id, n = self.number {
            self.title    = "Season " + String(n)
            self.year.text =  "Season " + String(n)
            
            http.getEpisodes(id, season: n,
                completion: { [weak self] r in
                    if let e = r.value {
                        self?.episodes = e  
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

                    vc.epi = e.number
                    vc.number = e.seasonNumber
                    vc.id = self.id
                    
            }
        }
    }
}
