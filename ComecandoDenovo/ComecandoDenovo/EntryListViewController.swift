//
//  EntryListViewController.swift
//  ComecandoDenovo
//
//  Created by iOS on 7/21/15.
//  Copyright (c) 2015 iOS. All rights reserved.
//

import UIKit
import SafariServices

class EntryListViewController : UIViewController ,
UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet private weak var tableView: UITableView!
    
    let entries:[Entry] = Entry.loadEntrys()!
    
    var fav: Set<Int> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 160.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(animated: Bool) {
        //super.viewDidAppear(false )
        tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1}
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let iden = "Entry"//Reusable.Entry.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(iden, forIndexPath: indexPath) as! EntryCell
        
        cell.loadEntry(entries[indexPath.row])
        
        if fav.contains(indexPath.row) {
            cell.backgroundColor = UIColor(red: 1, green: 191/255, blue: 1, alpha: 1)//UIColor.purpleColor()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        UIApplication.sharedApplication().openURL(entries[indexPath.row].link)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        //let cell = tableView.cellForRowAtIndexPath(indexPath)
        //cell!.backgroundColor = UIColor.whiteColor()
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?  {
        
        var readingList = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Read List" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            let favCell = UIAlertController(title: nil, message: "Added to Safari Reading List", preferredStyle: .ActionSheet)
            let allert = UIAlertAction(title: "Oookay", style: UIAlertActionStyle.Default, handler: nil)
            
            let e = self.entries[indexPath.row]
            
            var read: SSReadingList = SSReadingList.defaultReadingList()
            read.addReadingListItemWithURL(e.link, title: e.title, previewText: e.content, error: nil)
        
            
            favCell.addAction(allert)
            self.presentViewController(favCell, animated: true, completion: nil)
        })
        
        if fav.contains(indexPath.row){
            var undo = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Unfavorite" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
                
                let undoFav = UIAlertController(title: nil, message: "Removed from favorites", preferredStyle: .ActionSheet)
                let allert = UIAlertAction(title: "Done ;-; ", style: UIAlertActionStyle.Default, handler: nil)
                
                self.fav.remove(indexPath.row)
                
                undoFav.addAction(allert)
                self.presentViewController(undoFav, animated: true, completion: nil)
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
            
            return [undo, readingList]
        }
        
        
        var favorite = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Favorite" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            let favCell = UIAlertController(title: nil, message: "Added to favorites", preferredStyle: .ActionSheet)
            let allert = UIAlertAction(title: "Oookay", style: UIAlertActionStyle.Default, handler: nil)
            
            self.fav.insert(indexPath.row)
            
            favCell.addAction(allert)
            self.presentViewController(favCell, animated: true, completion: nil)
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        })
        
        return [favorite, readingList]
    }
    
    
    
}
