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
    
    var episode: TraktModels.Episode? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textOverview.textContainer.lineFragmentPadding = 0
        textOverview.textContainerInset = UIEdgeInsetsZero
        
        if let e = self.episode {
            episodeTitle.text = e.title
            textOverview.text = e.overview
            
            let date = NSDateFormatter()
            date.dateFormat = "EEE, d MM yyyy HH:mm::ss Z"
            time.text = date.stringFromDate(e.firstAired!)
            channel.text = ""

            if let img = e.screenshot?.fullImageURL ?? e.screenshot?.mediumImageURL ?? e.screenshot?.thumbImageURL{
                imageEpisode.kf_setImageWithURL(img)
            }
            
            self.title = "Episode " + String(e.number)
        }
    }
}