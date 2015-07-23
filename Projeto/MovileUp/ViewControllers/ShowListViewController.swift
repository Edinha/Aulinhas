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
    
    let http = TraktHTTPClient()
    
    private var shows:[TraktModels.Show] = []//Show.loadShow()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        http.getPopularShows({ [weak self] resultado in
            if let s = resultado.value {
                self?.shows = s
            }
        })
    }
    
    func numberOfSectionsInCollectionView(tableView: UICollectionView) -> Int { return 1}
    
    func collectionView(colView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func collectionView(colView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = colView.dequeueReusableCell(Reusable.Show, forIndexPath: indexPath) as! ShowCell
        
        cell.loadShow(shows[indexPath.item % shows.count])
        
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
            
            collectionView.deselectItemAtIndexPath(indexPath, animated: true)
            
            let cell = collectionView.cellForItemAtIndexPath(indexPath)
       
            let title: String = shows[indexPath.item % shows.count].title
            //let text : String = shows[indexPath.item % shows.count].name
            
            //let alertController = UIAlertController(title: title, message: text, preferredStyle: .Alert)
            //alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            
            //presentViewController(alertController, animated: true, completion: nil)
            
    }
}