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
    
    @IBOutlet private weak var status: UILabel!
    @IBOutlet private weak var started: UILabel!
    @IBOutlet private weak var country: UILabel!
    @IBOutlet private weak var network: UILabel!
    @IBOutlet private weak var airedEpisodes: UILabel!
    
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
            
            network.text = s.network!
            status.text = s.status?.rawValue
            airedEpisodes.text = String(s.airedEpisodes!)
            
            let date = NSDateFormatter()
            date.dateFormat = "EEE, d MM yyyy HH:mm::ss Z"
            started.text = date.stringFromDate(s.firstAired!)
            country.text = s.country!
        }
    }

    @IBAction func addToFavorites(sender: AnyObject) {
        
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 0.4
        pulseAnimation.fromValue = 1
        pulseAnimation.toValue = manager.isFavorited(id!) ? 1.2 : 0.8
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = 1
        let function = kCAMediaTimingFunctionEaseInEaseOut
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: function)
        sender.layer.addAnimation(pulseAnimation, forKey: nil)
        
        if manager.isFavorited(id!) {
            manager.removeIdentifier(id!)
            favorites.setImage(UIImage(named: "like-heart"), forState: UIControlState.Normal)
        } else {
            manager.addIdentifier(id!)
            favorites.setImage(UIImage(named: "like-heart-on"), forState: UIControlState.Normal)
        }
        
        let notification = NSNotificationCenter.defaultCenter()
        notification.postNotificationName(FavoriteManager.favoritesChanged, object: self)
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
                vc.title = s.title + " Seasons"
            
        }
    }
    
    deinit {
        print("\(self.dynamicType) deinit\n")
    }
}
