//
//  CurrentSeasonCell.swift
//  MovileUp
//
//  Created by iOS on 7/24/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import UIKit
import TraktModels
import Kingfisher

class CurrentSeasonCell : UITableViewCell {
    
    @IBOutlet weak var seasonStatus: UILabel!
    @IBOutlet weak var episodeCount: UILabel!
    @IBOutlet weak var seasonImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func loadSeason(s : TraktModels.Season, year : Int) {
        
        if let img = s.poster?.fullImageURL ?? s.poster?.mediumImageURL ?? s.poster?.thumbImageURL {
            seasonImage.kf_setImageWithURL(img)
        }
        
        seasonStatus.text = "Season " + String(s.number) + "(" + String(year) + ")"
        episodeCount.text = String(s.episodeCount!) + " episodes"
    }
}
