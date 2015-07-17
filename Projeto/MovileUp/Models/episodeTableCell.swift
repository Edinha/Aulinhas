//
//  episodeViewCell.swift
//  MovileUp
//
//  Created by iOS on 7/16/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import UIKit

class episodeTableCell : UITableViewCell {
    
   
    @IBOutlet private weak var episodeNumber: UILabel!
    
    
    @IBOutlet private weak var episodeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundColor = UIColor.whiteColor()
    }
    
    func loadEpisode(ep : Episode) {
    
        self.episodeName.text = ep.name
        self.episodeNumber.text = ep.episode
    }
}
