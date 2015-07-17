//
//  ShowCell.swift
//  MovileUp
//
//  Created by iOS on 7/17/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import UIKit

class ShowCell : UICollectionViewCell {
    
    
    @IBOutlet private weak var showImage: UIImageView!
    @IBOutlet private weak var showName: UILabel!
    
    func loadShow(s : Show) {
        showImage.image = UIImage(named: s.url)
        showName.text = s.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
