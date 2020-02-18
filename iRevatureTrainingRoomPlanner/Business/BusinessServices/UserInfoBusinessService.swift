//
//  UserInfoBusinessService.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/18/20.
//  Copyright © 2020 admin. All rights reserved.
//
import Foundation

class UserInfoBusinessService : UserInfoProtocol{
    
    func getUserInfo() -> User? {
        
        let currentUserDefault = UserDefaults.standard
        
        if let decodedUserInfo = (currentUserDefault.value(forKey: "UserSharedInfo")){
            
            let decodedUser = try? PropertyListDecoder().decode(User.self, from: decodedUserInfo as! Data)
        
            return decodedUser
        
        } else {
        
            return nil
        }
    }
    
    func setUserInfo(userObject: User) -> Bool {
        
        let currentUserDefault = UserDefaults.standard
        
        do{
            
            try? currentUserDefault.set(PropertyListEncoder().encode(userObject), forKey: "UserSharedInfo")
            
            return true
            
        } catch(_) {
            
            return false
            
        }
    }
    
    
}
