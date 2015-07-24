//
//  ShowCell.swift
//  MovileUp
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import UIKit
import TraktModels
import Kingfisher

class ShowCell : UICollectionViewCell {
    
    
    @IBOutlet private weak var showImage: UIImageView!
    @IBOutlet private weak var showName: UILabel!
    
    private var task: RetrieveImageTask?
    
    func loadShow(s : TraktModels.Show) {
        let placeholder = UIImage(named: "poster")
        
        if let url = s.poster?.fullImageURL ?? s.poster?.mediumImageURL ?? s.poster?.thumbImageURL {
            task = showImage.kf_setImageWithURL(url, placeholderImage: placeholder)
        } else {
            showImage.image = placeholder
        }
        
        showName.text = s.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        task?.cancel()
        task = nil
        showImage.image = nil
    }
}
