//
//  EntityManager.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by Jeremy Malisse on 2/19/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

/**
 Business Layer Service that handles all in-memory entities, API calls, and Persistence actions.

 *Values*

  Documentation needs updating.

 - Author:
    Jeremy Malisse
 - Version:
   0.1
*/
class EntityManager
{
    // MARK: Application Entities/Containers

    var activeUser : User?
    var trainerList : [Trainer]
    var roomList : [Room]
    var locationList : [Location]
    var campusList : [APICampus]
    
    init()
    {
        activeUser = nil
        trainerList = [Trainer]()
        roomList = [Room]()
        locationList = [Location]()
        campusList = [APICampus]()
    }
    
    let API = RevatureAPI()
    

    
    
    //MARK: API Request Methods
    func login(email: String, password: String, keepLoggedIn: Bool, finish: @escaping (_ success: Bool) -> Void )
    {
        API.performLogin(email: email, password: password, finish: {
            
            login in
            
            // login data accessed here
            
            self.activeUser = User(firstName: "", lastName: "", primaryLocation: login.primaryLocation, email: email, keepLoggedIn: keepLoggedIn, loginToken: login.loginToken, currentRole: login.currentSystemRole)
            
            if self.activeUser != nil
            {
                finish(true)
            }
            else
            {
                finish(false)
            }
        })
        
        #warning("After abstracting this functionality to the business layer - we can no longer rely on this to come through in time for the user to be set before making the segue - I feel we will need to make this a delegate using a login Protocol that returns to tell us whether we can login or not")
        
    }
    
    
    
    
    func requestAllAPI()
    {
        self.API.requestLocations(finish:
            {
                locationCall in
                
                self.locationList = [Location]()
                
                for location in locationCall.alllocation
                {
                    let loc = Location(id: location.id, state: location.state, campus: location.campus, building: location.building)
                    self.locationList.append(loc)
                }
                
                for loc in self.locationList
                {
                    print("loc: \(loc)")
                }
        })
    }
    
    
    
    
    
    
    
    // MARK: Persistence Layer Methods
    /// Subsection 1: API -> SQLite Database
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: Persistence Layer Methods
    /// Subsection 2: SQLite Data -> Business Class (Application Layer)
    
    
    

    
}
