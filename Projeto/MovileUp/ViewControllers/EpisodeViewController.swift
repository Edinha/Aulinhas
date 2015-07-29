//
//  EpisodeViewController.swift
//  MovileUp
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import UIKit
import Result
import TraktModels
import Kingfisher

class EpisodeViewController : UIViewController {
    
    @IBOutlet private weak var episodeTitle: UILabel!
    
    @IBOutlet private weak var textOverview: UITextView!
    
    @IBOutlet private weak var imageEpisode: UIImageView!
    
    @IBOutlet private weak var channel: UILabel!
    
    @IBOutlet private weak var time: UILabel!
    
    var episode:TraktModels.Episode? = nil
    
    var id: String? = nil
    var number: Int? = nil
    var epi: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let epi = self.epi, n = self.number, slug = self.id, e = self.episode {
            
            textOverview.textContainer.lineFragmentPadding = 0
            textOverview.textContainerInset = UIEdgeInsetsZero
            
            self.title = "Episode " + String(n)
            self.episodeTitle.text = e.title
            self.textOverview.text = e.overview
            
            let date = NSDateFormatter()
            date.dateFormat = "EEE, d MM yyyy HH:mm::ss Z"
            self.time.text = date.stringFromDate(e.firstAired!)
            self.channel.text = ""
            
            if let img = e.screenshot?.fullImageURL ?? e.screenshot?.mediumImageURL ?? e.screenshot?.thumbImageURL{
                self.imageEpisode.kf_setImageWithURL(img)
            }

        }
    }
    
}