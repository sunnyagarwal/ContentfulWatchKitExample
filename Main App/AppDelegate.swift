//
//  AppDelegate.swift
//  WatchKitExample
//
//  Created by Boris Bügling on 19/11/14.
//  Copyright (c) 2014 Contentful GmbH. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var locationManager: CLLocationManager?
    var watchKitReply: (([NSObject : AnyObject]!) -> Void)! = nil
    var window: UIWindow?

    func startUpdatingLocation() {
        locationManager = CLLocationManager()
        locationManager!.delegate = self;
        locationManager!.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager!.distanceFilter = 1000
        locationManager!.requestAlwaysAuthorization()
        locationManager!.startUpdatingLocation()
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        startUpdatingLocation()
        return true
    }

    func application(application: UIApplication!, handleWatchKitExtensionRequest userInfo: [NSObject : AnyObject]!, reply: (([NSObject : AnyObject]!) -> Void)!) {
        NSLog("Received WatchKit extension request.")

        startUpdatingLocation()

        self.watchKitReply = reply
    }

    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        if newLocation == nil {
            return
        }

        var location = newLocation!.coordinate

        if let reply = self.watchKitReply {
            reply(["currentLocation": NSValue(MKCoordinate:location)])
        }

        NSLog("Sent location to WatchKit extension.")
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

