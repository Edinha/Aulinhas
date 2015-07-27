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
    //let http = TraktHTTPClient()
    private var task: RetrieveImageTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let s = self.show {
            
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "current_season",
            let v = sender as? UIViewController, s = self.show,
            slug = s.identifiers.slug {

                self.title = s.title
                self.year.text = String(s.year)
                self.storyline.text = s.overview
                
                let placeholder = UIImage(named: "poster")
                if let url = s.thumbImageURL {
                    image.kf_setImageWithURL(url, placeholderImage: placeholder)
                } else {
                    image.image = placeholder
                }
                
                let vc = segue.destinationViewController as! CurrentSeasonViewController
                vc.slug = slug
            }
            
        
    }
}
