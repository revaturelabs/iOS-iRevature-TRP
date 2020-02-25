//
//  RevatureAuthorization.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by Jeremy Malisse on 2/21/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Alamofire


#warning("Will need to update the headers of each of these .get endpoints to check the Bearer authorization - is currently not required in the training API, but will be necessary for the Dev Env API")
class AuthorizationAPI
{
    
    /**
     RevatureAPI call to receive list of all locations from the API endpoint `login`
    
     *Values*
    
     `finish` The escaping method used to return `APIUserCall` data to the Business Layer
     
     Requires the right endpoint classification and the reference to the Decodable entity type
     that it will parse the data received into.
     
     `response.value` is the actual data received from the API.

     - Author:
        Jeremy Malisse
     - Version:
       0.1
    */
    func performLogin(email: String, password: String, finish: @escaping (_ uservar: APIUserCall) -> Void )
    {
        
        let auth = Authentication(email: email, password: password.toBase64())
        
        AF.request(API.ENDPOINT.login, method: .post, parameters: auth, encoder: JSONParameterEncoder.default).validate().responseDecodable(of: APIUserCall.self)
        {
            response in
            guard let tempuser = response.value else
            {
                print("Error with login API call")
                print(response.error?.errorDescription as Any)
                return
            }
            
            finish(tempuser)
        }
    }
    
    /**
     RevatureAPI call to receive list of all locations from the API endpoint `location`
    
     *Values*
    
     `finish` The escaping method used to return `APILocationCall` data to the Business Layer
     
     Requires the right endpoint classification and the reference to the Decodable entity type
     that it will parse the data received into.
     
     `response.value` is the actual data received from the API.

     - Author:
        Jeremy Malisse
     - Version:
       0.1
    */
    func requestLocations(finish: @escaping (_ locationCall: APILocationCall) -> Void)
    {
        AF.request(API.ENDPOINT.locations, method: .get, parameters: nil).validate().responseDecodable(of: APILocationCall.self)
        {
            response in
            
            guard let templocs = response.value else
            {
                print("Error with location API call")
                print(response.error?.errorDescription as Any)
                return
            }
            
            finish(templocs)
        }
    }
    
    /**
     RevatureAPI call to receive list of all trainers from the API endpoint `trainers`
    
     *Values*
    
     `finish` The escaping method used to return `APITrainerCall` data to the Business Layer
     
     Requires the right endpoint classification and the reference to the Decodable entity type
     that it will parse the data received into.
     
     `response.value` is the actual data received from the API.
    
     - Author:
        Jeremy Malisse
     - Version:
       0.1
    */
    func requestTrainers(finish: @escaping (_ trainerCall: APITrainerCall) -> Void)
    {
        AF.request(API.ENDPOINT.trainers, method: .get, parameters: nil).validate().responseDecodable(of: APITrainerCall.self)
        {
            response in
            
            guard let temptrainer = response.value else
            {
                print("Error with trainer API call")
                print(response.error?.errorDescription as Any)
                return
            }
            
            finish(temptrainer)
        }
    }
    
    
    
    /**
     RevatureAPI call to receive list of all rooms from the API endpoint `rooms`
    
     *Values*
    
     `finish` The escaping method used to return `APIRoomCall` data to the Business Layer
     
     Requires the right endpoint classification and the reference to the Decodable entity type
     that it will parse the data received into.
     
     `response.value` is the actual data received from the API.
    
     - Author:
        Jeremy Malisse
     - Version:
       0.1
    */
    func requestRooms(finish: @escaping (_ roomCall: APIRoomCall) -> Void)
    {
        AF.request(API.ENDPOINT.rooms, method: .get, parameters: nil).validate().responseDecodable(of: APIRoomCall.self)
        {
            response in
            
            guard let temprooms = response.value else
            {
                print("Error with room API call")
                print(response.error?.errorDescription as Any)
                return
            }
            
            finish(temprooms)
        }
    }
    
    
    /**
     RevatureAPI call to receive list of all skills from the API endpoint `skills`
    
     *Values*
    
     `finish` The escaping method used to return `APISkillCall` data to the Business Layer
     
     Requires the right endpoint classification and the reference to the Decodable entity type
     that it will parse the data received into.
     
     `response.value` is the actual data received from the API.
    
     - Author:
        Jeremy Malisse
     - Version:
       0.1
    */
    func requestSkills(finish: @escaping (_ roomCall: APISkillCall) -> Void)
    {
        AF.request(API.ENDPOINT.skills, method: .get, parameters: nil).validate().responseDecodable(of: APISkillCall.self)
        {
            response in
            
            guard let tempskills = response.value else
            {
                print("Error with skill API call")
                print(response.error?.errorDescription as Any)
                return
            }
            
            finish(tempskills)
        }
    }
    
    /**
     RevatureAPI call to receive list of all batches from the API endpoint `batches`
    
     *Values*
    
     `finish` The escaping method used to return `APIBatchCall` data to the Business Layer
     
     Requires the right endpoint classification and the reference to the Decodable entity type
     that it will parse the data received into.
     
     `response.value` is the actual data received from the API.

     - Author:
        Jeremy Malisse
     - Version:
       0.1
    */
    func requestBatches(finish: @escaping (_ batchCall: APIBatchCall) -> Void)
    {
        AF.request(API.ENDPOINT.batches, method: .get, parameters: nil).validate().responseDecodable(of: APIBatchCall.self)
        {
            response in
            
            guard let tempbatches = response.value else
            {
                print("Error with batch API call")
                print(response.error?.errorDescription as Any)
                return
            }
            
            finish(tempbatches)
        }
    }
}

extension String
{
    
    /**
     String class extension for converting a `String` to an encrypted String

     *Values*

     `toBase64` The method used to convert any .uft8 compatible `String` to its base64Encoded version
     
     Extension of String class to convert a string into a base64Encoded string
     Currently used as encryption for password authentication over API call.
     
     - Return: `String` as base64Encoded String

     - Author:
        Jeremy Malisse
     - Version:
       0.1
    */
    func toBase64() -> String
    {
        let data = Data(self.utf8).base64EncodedString()
        
        return data
    }
}
