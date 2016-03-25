//
//  AppDelegate.swift
//  QBnB
//
//  Created by Mitchell Waite on 2016-02-28.
//  Copyright © 2016 Mitchell Waite. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let cookiesStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let cookieDictionary = userDefaults.dictionaryForKey("qbnb") {
            
            for (_, cookieProperties) in cookieDictionary {
                if let cookie = NSHTTPCookie(properties: cookieProperties as! [String : AnyObject] ) {
                    cookiesStorage.setCookie(cookie)
                }
            }
        }

        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
       
        
        let cookiesStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        let serverBaseUrl = "http://Mitchells-iMac.local"
        var cookieDict = [String : AnyObject]()
        
        for cookie in cookiesStorage.cookiesForURL(NSURL(string: serverBaseUrl)!)! {
            cookieDict[cookie.name] = cookie.properties
        }
        
        userDefaults.setObject(cookieDict, forKey: "qbnb")
    
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

