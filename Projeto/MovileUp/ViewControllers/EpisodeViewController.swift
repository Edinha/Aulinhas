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

class EpisodeViewController : UIViewController {
    
    @IBOutlet private weak var episodeTitle: UILabel!
    
    @IBOutlet private weak var textOverview: UITextView!
    
    @IBOutlet private weak var imageEpisode: UIImageView!
    
    @IBOutlet weak var channel: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    let http = TraktHTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textOverview.textContainer.lineFragmentPadding = 0
        textOverview.textContainerInset = UIEdgeInsetsZero
        
        http.getEpisode("game-of-thrones", season: 2, episode: 1,
            completion: { [weak self] resultado in
            
            if let epi = resultado.value {
                self?.episodeTitle.text = epi.title
                self?.textOverview.text = epi.overview
                
                if let data = NSData(contentsOfURL: epi.screenshot!.fullImageURL!){
                    //self.imageEpisode.contentMode = UIViewContentMode.ScaleAspectFit
                    self?.imageEpisode.image = UIImage(data: data)
                }
            }
            
        })
    }
}