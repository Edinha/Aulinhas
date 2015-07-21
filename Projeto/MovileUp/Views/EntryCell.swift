//
//  EntryCell.swift
//  MovileUp
//
//  Created by iOS on 7/20/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import UIKit

class EntryCell : UITableViewCell {
    
    
    @IBOutlet private weak var title: UILabel!
    
    @IBOutlet private weak var content: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundColor = UIColor.whiteColor()
        
        self.title.font   = UIFont(name: "HelveticaNeue-Light", size:16)
        self.content.font = UIFont(name: "HelveticaNeue-Light", size:14)
    }
    
    func loadEntry(e : Entry) {
        
        let cal = NSCalendar.currentCalendar()
        
        if cal.isDateInToday(e.publishedDate) {
            self.title.font   = UIFont(name: "HelveticaNeue-Bold", size:16)
            self.content.font = UIFont(name: "HelveticaNeue-Bold", size:14)
        }
        
        self.title.text = e.title
        let c = split (e.contentSnippet) { $0 == "\n"}
        self.content.text = c[0]
    }
    
    func boldContents() {
        
    }
}
