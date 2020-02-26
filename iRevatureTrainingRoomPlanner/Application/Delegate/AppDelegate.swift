//
//  AppDelegate.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/11/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var manager : EntityManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        #warning("NEED TO EMPTY OUT THE PREVIOUS USER DEFAULT IF KEEP LOGGED ON BECOMES DISABLED")
        
        manager = EntityManager()
        
        // verify tables exist, if not make em
        
        // if first time run -> api
        // otherwise -> database selects -> into memory
        
        
        
        if manager?.verifyPreviousLogin() == true
        {
            manager!.requestAllAPI()
        }
        else
        {
            
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
