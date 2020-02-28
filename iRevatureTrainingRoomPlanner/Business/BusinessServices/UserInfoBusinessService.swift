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
    let currentUserDefault = UserDefaults.standard
    
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
