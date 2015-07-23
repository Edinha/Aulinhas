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
        
        if let img = s.poster?.fullImageURL ?? s.poster?.mediumImageURL ?? s.poster?.thumbImageURL,
            data = NSData(contentsOfURL: img) {
            showImage.image = UIImage(data: data)
        }
        
        showName.text = s.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        showImage.image = UIImage(named: "poster")
    }
}
