//
//  SeasonListViewController.swift
//  MovileUp
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import UIKit

class SeasonListViewController : UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet private weak var collection: UICollectionView!
    
    let seasons = Season.loadSeasons()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSectionsInCollectionView(tableView: UICollectionView) -> Int { return 1}
    
    func collectionView(colView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2 * seasons.count
    }
    
    func collectionView(colView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = colView.dequeueReusableCell(Reusable.Season, forIndexPath: indexPath) as! SeasonCell
        
        cell.loadCell(seasons[indexPath.item % seasons.count])
        
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
}
