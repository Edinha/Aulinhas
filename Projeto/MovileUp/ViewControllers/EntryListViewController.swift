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
    
    //var
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 130.0
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
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
        
        //let cell = tableView.cellForRowAtIndexPath(indexPath)
        //cell!.boldContents()
        
        //UIApplication.sharedApplication().openURL(entries[indexPath.row].link)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        //let cell = tableView.cellForRowAtIndexPath(indexPath)
        //cell!.backgroundColor = UIColor.whiteColor()

    }
}
