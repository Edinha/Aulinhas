//
//  ShowScrollViewController.swift
//  MovileUp
//
//  Created by iOS on 7/30/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import UIKit
import TraktModels
import Kingfisher
import FloatRatingView
import TagListView

class ShowScrollViewController : UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var rating: FloatRatingView!
    @IBOutlet weak var ratingNumber: UILabel!
    @IBOutlet weak var favorites: UIButton!
    @IBOutlet weak var storyline: UITextView!
    @IBOutlet weak var genres: TagListView!
    
    @IBOutlet weak var network: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var airedEpisodes: UILabel!
    @IBOutlet weak var started: UILabel!
    
    var id: Int? = nil
    var show: TraktModels.Show? = nil
    var manager = FavoriteManager()
    let http = TraktHTTPClient()
    private var task: RetrieveImageTask?
    
    @IBOutlet private weak var constraint: NSLayoutConstraint!
    var viewController : SeasonListScrollViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let s = self.show {
            
            self.title = s.title
            self.year.text = String(s.year)
            self.storyline.text = s.overview!
            self.rating.rating = s.rating!
            self.ratingNumber.text = String(format: "%.1f", s.rating!)
            
            for g in s.genres! {
                genres.addTag(g)
            }
            
            if let i = s.thumbImageURL {
                self.image.kf_setImageWithURL(i )
            }
            
            if manager.isFavorited(id!) {
                favorites.setImage(UIImage(named: "like-heart-on"), forState: UIControlState.Normal)
            }
            
            network.text = s.network!
            status.text = s.status?.rawValue
            airedEpisodes.text = String(s.airedEpisodes!)
            
            //let date = NSDateFormatter()
            //date.dateFormat = "EEE, d MM yyyy HH:mm::ss Z"
            started.text = String(s.year) //date.stringFromDate(s.firstAired!)
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
        if segue.identifier == "scroll_season",
            let s = self.show {
            
                self.title = s.title
                self.year.text = String(s.year)
                self.storyline.text = s.overview!
                self.rating.rating = s.rating!
                self.ratingNumber.text = String(format: "%.1f", s.rating!)
            
                for g in s.genres! {
                    genres.addTag(g)
                }
                    
                if let i = s.thumbImageURL {
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
         
                let vc = segue.destinationViewController as! SeasonListScrollViewController
                vc.id = s.identifiers.slug
                vc.title = s.title + " Seasons"
                viewController = segue.destinationViewController as? SeasonListScrollViewController
        }
    
        if segue.identifier == "seasons_button"{
            let s = show!
            let vc = segue.destinationViewController as! SeasonListViewController
            vc.id = s.identifiers.slug
            vc.title = s.title + " Seasons"
        }
    }
    
    override func viewWillLayoutSubviews() {
        
        // fornecer as constraints aqui
        //constraint.constant = viewController!.loadConstraint().height
        
    }
    
    deinit {
        print("\(self.dynamicType) deinit\n")
    }
}
