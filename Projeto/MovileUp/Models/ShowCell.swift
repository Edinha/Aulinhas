//
//  ShowCell.swift
//  MovileUp
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import UIKit
import TraktModels

class ShowCell : UICollectionViewCell {
    
    
    @IBOutlet private weak var showImage: UIImageView!
    @IBOutlet private weak var showName: UILabel!
    
    func loadShow(s : TraktModels.Show) {
        //showImage.image = UIImage(named: s.poster?.fullImageURL!)
        showName.text = s.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
