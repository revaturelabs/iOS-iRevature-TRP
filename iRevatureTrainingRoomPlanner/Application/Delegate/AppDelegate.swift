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
        
        // should be doing our database and API calls here (outside of the login authentication)
        
        //MARK: Initializes tables
//        DatabaseOperations().createUserTable()
//        DatabaseOperations().createTrainerTable()
//        DatabaseOperations().createRoomTable()
//        DatabaseOperations().createSkillTable()
//        DatabaseOperations().createCalendarTable()
//        DatabaseOperations().enterDummyData()
        
        #warning("NEED TO EMPTY OUT THE PREVIOUS USER DEFAULT IF KEEP LOGGED ON BECOMES DISABLED")
        
        manager = EntityManager()
        
        if manager?.verifyPreviousLogin() == true
        {
            manager!.requestAllAPI()
        }
        else
        {
        }
        
        // still not understanding the point of that on the first launch, as the token hasnt been acquired yet, and therefor cant be used to authenticate the API endpoint with credentials to acquire data
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
