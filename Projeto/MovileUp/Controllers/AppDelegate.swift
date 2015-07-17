//
//  AppDelegate.swift
//  MovileUp
//
//  Created by iOS on 7/15/15
//  Copyright (c) 2015 Edinha's. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        let apperarance = UINavigationBar.appearance()
        
        apperarance.barTintColor = UIColor.orangeColor()
        
        let attrs = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        apperarance.titleTextAttributes = attrs
        apperarance.tintColor = UIColor.whiteColor()
        
        return true
    }
}
