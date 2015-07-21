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
    
    //var fav: [Int] = []
    var fav: Set<Int> = []
    
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
        
        /*for f in fav {
            if f == indexPath.row{
                cell.backgroundColor = UIColor.blueColor()
                break
            }
        } */
        
        if fav.contains(indexPath.row) {
            cell.backgroundColor = UIColor.blueColor()
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
     
        
        var favorite = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Favorites" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            let favCell = UIAlertController(title: nil, message: "Added to favorites", preferredStyle: .ActionSheet)
            let allert = UIAlertAction(title: "Oookay", style: UIAlertActionStyle.Default, handler: nil)
            
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            cell!.backgroundColor = UIColor.blueColor()
            self.fav.insert(indexPath.row)
            
            favCell.addAction(allert)
            self.presentViewController(favCell, animated: true, completion: nil)
        })
        
        if fav.contains(indexPath.row){
            var undo = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Remove" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
                let cell = tableView.cellForRowAtIndexPath(indexPath)
                cell?.backgroundColor = UIColor.whiteColor()
                
                let undoFav = UIAlertController(title: nil, message: "Removed from favorites", preferredStyle: .ActionSheet)
                let allert = UIAlertAction(title: "Done ;-; ", style: UIAlertActionStyle.Default, handler: nil)
            
                self.fav.remove(indexPath.row)
                
                undoFav.addAction(allert)
                self.presentViewController(undoFav, animated: true, completion: nil)
            })
            
            return [favorite, undo]
        }
        
        return [favorite]
    }
    
    
    
}
