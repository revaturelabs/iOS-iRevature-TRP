//
//  RevatureAuthorization.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by Jeremy Malisse on 2/21/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Alamofire

class AuthorizationAPI
{
    func performLogin(email: String, password: String, finish: @escaping (_ uservar: CurrentUser) -> Void )
    {
        
        let auth = Authentication(email: email, password: password.toBase64())
        
        AF.request(API.ENDPOINT.login, method: .post, parameters: auth, encoder: JSONParameterEncoder.default).validate().responseDecodable(of: CurrentUser.self)
        {
            (response) in
            guard let tempuser = response.value else
            {
                print("Error appeared")
                print(response.error?.errorDescription as Any)
                return
            }
            
            print("response successful")
            
            print("User token: \(tempuser.loginToken)")
            
            finish(tempuser)
        }
    }
    
    func requestLocations(finish: @escaping (_ locationCall: APILocationCall) -> Void)
    {
        AF.request(API.ENDPOINT.location, method: .get, parameters: nil).validate().responseDecodable(of: APILocationCall.self)
        {
            response in
            
            guard let templocs = response.value else
            {
                print("Error with loc API call")
                print(response.error?.errorDescription as Any)
                return
            }
            
            finish(templocs)
        }
    }
    
//    func requestTrainers(finish: @escaping (_ trainerCall: ))
//    {
//
//    }
}

extension String
{
    func toBase64() -> String
    {
        let data = Data(self.utf8).base64EncodedString()
        
        return data
    }
}
