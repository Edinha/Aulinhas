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
import FloatRatingView

class CurrentSeasonCell : UITableViewCell {
    
    @IBOutlet weak var seasonImage: UIImageView!
    
    @IBOutlet weak var seasonNumber: UILabel!
    
    @IBOutlet weak var episodeCount: UILabel!
    
    @IBOutlet private weak var rating: FloatRatingView!
    
    @IBOutlet private weak var ratingNumber: UILabel!
    
    private var task: RetrieveImageTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
        task = nil
        seasonImage.image = nil
    }
    
    func loadSeason(s : TraktModels.Season) {
        
        
        if let img = s.poster?.fullImageURL ?? s.poster?.mediumImageURL ?? s.poster?.thumbImageURL {
            task = seasonImage.kf_setImageWithURL(img)
        }
        
        seasonNumber.text = "Season " + String(s.number)
        let count = String(s.episodeCount!) + " episodes"
        episodeCount.text = count
       
        rating.rating = s.rating!
        ratingNumber.text = String(format: "%.1f", s.rating!)
    }
    
}
