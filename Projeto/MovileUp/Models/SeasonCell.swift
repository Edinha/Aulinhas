//
//  SeasonCell.swift
//  MovileUp
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import UIKit

class SeasonCell : UICollectionViewCell {
    
    
    @IBOutlet private weak var seasonImage: UIImageView!
    
    
    @IBOutlet private weak var seasonName: UILabel!
    
    func loadCell(s : Season) {
     
        seasonImage.image = UIImage(named: s.url)
        seasonName.text = s.name
    }
}
