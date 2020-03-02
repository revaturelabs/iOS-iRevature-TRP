//
//  UserInfoBusinessService.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/18/20.
//  Modified by Jeremy Malisse on 2/26/2020.
//  Copyright © 2020 admin. All rights reserved.
//
import Foundation

class UserInfoBusinessService : UserInfoProtocol
{
    // Sets the current user default store as the standard store
    let currentUserDefault = UserDefaults.standard
    
    // Returns the current User that is active in the system, if no user had been saved then return nil
    func getUserInfo() -> User?
    {
        if let decodedUserInfo = (currentUserDefault.value(forKey: "UserSharedInfo") as? Data)
        {
            let decodedUser = try? PropertyListDecoder().decode(User.self, from: decodedUserInfo)
            return decodedUser
        
        } else {
        
            return nil
        }
    }
    
    // Saves a User object into the system if the user has requested to "Keep Me Logged In"
    func setUserInfo(userObject: User)
    {
        do
        {
            try currentUserDefault.set(PropertyListEncoder().encode(userObject), forKey: "UserSharedInfo")
        }
        catch (_)
        {

        }
    }
    
    // Clears the currently saved user info from the system, useful if the "Keep Me Logged In" status has changed or if another, different, User has logged into the system
    func clearUserInfo()
    {
        let userDefaults = UserDefaults.standard
        let dict = userDefaults.dictionaryRepresentation() as NSDictionary

        for _ in dict.allKeys
        {
                userDefaults.removeObject(forKey: "UserSharedInfo")
        }

        userDefaults.synchronize()
    }
}
