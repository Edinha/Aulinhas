//
//  ShowListViewController.swift
//  MovileUp
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import UIKit
import Result
import TraktModels

class ShowListViewController : UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var listShows: UISegmentedControl!
    
    let http = TraktHTTPClient()
    var manager = FavoriteManager()
    private var shows:[TraktModels.Show] = []
    var favorites:[TraktModels.Show] = []
    var modeShow: [TraktModels.Show]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for f in manager.favoritesIdentifiers{
            http.getShow(String(f), completion: {
                [weak self] resultado in
                if let value = resultado.value {
                    self?.favorites.append(value)
                    print(value)
                }
            })
        }
        
        http.getPopularShows({ [weak self] resultado in
            if let s = resultado.value {
                self?.shows = s
                self?.collectionView.reloadData()
            }
        })
        
        self.modeShow = self.shows
    }
    
    func numberOfSectionsInCollectionView(tableView: UICollectionView) -> Int { return 1}
    
    func collectionView(colView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func collectionView(colView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = colView.dequeueReusableCell(Reusable.Show, forIndexPath: indexPath) as! ShowCell
        
        cell.loadShow(modeShow![indexPath.item])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let border = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let itemSize = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
        let maxPerRow = floor((collectionView.bounds.width - border) / itemSize)
        let usedSpace = border + itemSize * maxPerRow
        let space = floor((collectionView.bounds.width - usedSpace) / 2)
        
        return UIEdgeInsets(top: flowLayout.sectionInset.top, left: space,
            bottom: flowLayout.sectionInset.bottom, right: space)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
            
            //collectionView.deselectItemAtIndexPath(indexPath, animated: true)
            
            //let cell = collectionView.cellForItemAtIndexPath(indexPath)
       
            //let title: String = shows[indexPath.item % shows.count].title
            //let text : String = shows[indexPath.item % shows.count].name
            
            //let alertController = UIAlertController(title: title, message: text, preferredStyle: .Alert)
            //alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            
            //presentViewController(alertController, animated: true, completion: nil)
            
    }
    
    
    @IBAction func listByType(sender: AnyObject) {
        
        if listShows.selectedSegmentIndex == 0 {
            modeShow = shows
        } else {
            modeShow = favorites
        }
        
        
        collectionView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "show_show" {
            if let cell = sender as? ShowCell,
                indexPath = collectionView.indexPathForCell(cell){
                    
                    let s = shows[indexPath.item]
                    let vc = segue.destinationViewController as! ShowViewController
                    vc.id = s.identifiers.trakt
                    vc.show = s
                    
            }
        }
        
        if segue.identifier == "show_seasons" {
            if let cell = sender as? ShowCell,
                indexPath = collectionView.indexPathForCell(cell){
                    let s = shows[indexPath.item]
                    let vc = segue.destinationViewController as! SeasonListViewController
                    vc.id = s.identifiers.slug
                    vc.title = s.title
            }
        }
    }
}