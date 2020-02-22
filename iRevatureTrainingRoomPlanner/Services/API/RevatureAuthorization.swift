//
//  RevatureAuthorization.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by Jeremy Malisse on 2/21/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Alamofire

struct Login : Encodable
{
  let email : String
  let password : String
}

class AuthorizationAPI
{
    
}

extension String
{
    func toBase64() -> String
    {
        let data = Data(self.utf8).base64EncodedString()
        
        return data
    }
}
