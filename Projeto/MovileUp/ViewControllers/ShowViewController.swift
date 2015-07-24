//
//  ShowViewController.swift
//  MovileUp
//
//  Created by iOS on 7/24/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import UIKit
import TraktModels
import Kingfisher

class ShowViewController : UIViewController {
    
    
    @IBOutlet private weak var image: UIImageView!
    
    @IBOutlet private weak var year: UILabel!
    
    @IBOutlet private weak var storyline: UITextView!
    
    var show: TraktModels.Show? = nil
    var seasons: [TraktModels.Season] = []
    let http = TraktHTTPClient()
    private var task: RetrieveImageTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let s = self.show {
            
            http.getSeasons(s.identifiers.slug! , completion: { [weak self] resultado in
                
                if let value = resultado.value {
                    
                    self?.seasons = value
                    let current = self?.seasons[self!.seasons.count-1]
                    //colocar as parada aqui, provavelmente uma outlet para view :P
                    self?.title = s.title
                }
            })
            
            self.year.text = String(s.year)
            self.storyline.text = s.overview
            
            let placeholder = UIImage(named: "poster")
            if let url = s.thumbImageURL {//s.poster?.fullImageURL ?? s.poster?.mediumImageURL ?? s.poster?.thumbImageURL {
                image.kf_setImageWithURL(url, placeholderImage: placeholder)
            } else {
                image.image = placeholder
            }
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "season_info" {
            //if let cell = sender as? CurrentSeasonCell {
            let vc = segue.destinationViewController as! ListEpisodesViewController
            vc.season = self.seasons[self.seasons.count - 1]
            //vc.year = self.year
            //}
        }
        
    }
}
