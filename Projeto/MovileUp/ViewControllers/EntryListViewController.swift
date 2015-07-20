//
//  EntryListViewController.swift
//  MovileUp
//
//  Created by iOS on 7/20/15.
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import UIKit

class EntryListViewController : UIViewController ,
    UITableViewDelegate, UITableViewDataSource {


    @IBOutlet private weak var tableView: UITableView!
    
    let entries:[Entry] = Feed.loadEntrys()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1}
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let iden = Reusable.Entry.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(iden, forIndexPath: indexPath) as! EntryCell
        
        cell.loadEntry(entries[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell!.backgroundColor = UIColor.blueColor()
    }
    
    
}
