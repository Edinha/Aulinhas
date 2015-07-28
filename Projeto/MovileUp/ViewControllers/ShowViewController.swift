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
import FloatRatingView
import TagListView

class ShowViewController : UIViewController {
    
    
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var year: UILabel!
    @IBOutlet private weak var storyline: UITextView!
    @IBOutlet private weak var genres: TagListView!
    
    @IBOutlet private weak var favorites: UIButton!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var rating: FloatRatingView!
    
    var id: Int? = nil
    var show: TraktModels.Show? = nil
    var manager = FavoriteManager()
    let http = TraktHTTPClient()
    private var task: RetrieveImageTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let s = self.show {
            
            self.title = s.title
            self.year.text = String(s.year)
            self.storyline.text = s.overview!
            self.rating.rating = s.rating!
            self.ratingLabel.text = String(format: "%.1f", s.rating!)
            
            for g in s.genres! {
                genres.addTag(g)
            }
            
            let img = s.poster?.fullImageURL ?? s.poster?.mediumImageURL ?? s.poster?.thumbImageURL

            if let i = img {
                self.image.kf_setImageWithURL(i )
            }
            
            if manager.isFavorited(id!) {
                favorites.setImage(UIImage(named: "like-heart-on"), forState: UIControlState.Normal)
            }
        }
    }

    @IBAction func addToFavorites(sender: AnyObject) {
        
        if manager.isFavorited(id!) {
            manager.removeIdentifier(id!)
            favorites.setImage(UIImage(named: "like-heart"), forState: UIControlState.Normal)
            //print("unfavorited\n")
        } else {
            manager.addIdentifier(id!)
            favorites.setImage(UIImage(named: "like-heart-on"), forState: UIControlState.Normal)
            //print("favorited\n")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "show",
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
            
        if segue.identifier == "show_seasons"{
                let s = show!
                let vc = segue.destinationViewController as! SeasonListViewController
                vc.id = s.identifiers.slug
                vc.title = s.title
            
        }
    }
}
