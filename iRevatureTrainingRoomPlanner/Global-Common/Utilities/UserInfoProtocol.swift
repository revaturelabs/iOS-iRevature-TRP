//
//  UserInfoProtocol.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/18/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import KeychainSwift

protocol UserInfoProtocol {
    
    func getUserInfo() -> User?
    func setUserInfo(userObject:User)
    func clearUserInfo()
}
