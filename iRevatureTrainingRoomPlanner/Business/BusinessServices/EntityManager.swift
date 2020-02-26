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
    #warning("Create this as a singleton? Should never instantiate another EM outside the one in the AppDelegate")
    
    // MARK: Application Entities/Containers

    var activeUser : User?
    var trainerList : [Trainer]
    var roomList : [Room]
    var locationList : [Location]
    var campusList : [Campus]
    var skillList : [APISkill]
    //var batchList : [Batch]
    
    var userInfoBusinessService : UserInfoBusinessService = UserInfoBusinessService()
    
    
    init()
    {
        activeUser = nil
        trainerList = [Trainer]()
        roomList = [Room]()
        locationList = [Location]()
        campusList = [Campus]()
        skillList = [APISkill]()
        //batchList = [Batch]()
    }
    
    let API = RevatureAPI()
    
    #warning("finish markup in-line documentation for these methods")
    
    //MARK: API Request Methods
    func login(email: String, password: String, keepLoggedIn: Bool, finish: @escaping (_ success: Bool) -> Void )
    {
        API.performLogin(email: email, password: password, finish: {
            
            login in
            
            // Access the login data here and store it in the active User var
            self.activeUser = User(firstName: "", lastName: "", primaryLocation: login.primaryLocation, email: email, keepLoggedIn: keepLoggedIn, loginToken: login.loginToken, currentRole: login.currentSystemRole)
            
            
            if self.activeUser != nil
            {
                // If the User has asked to remain logged in
                // Set the UserDefaults to persist their data
                if(self.activeUser?.keepLoggedIn == true)
                {
                    self.userInfoBusinessService.setUserInfo(userObject: self.activeUser!)
                }
                
            // Either way call the completion handler which determines
            //  whether there will be a segue or not based on all verification so far
                finish(true)
            }
            else
            {
                finish(false)
            }
        })
    }
    
    
    func requestAllAPI()
    {
        print("Requesting all APIs....")
        // Request locations
        self.API.requestLocations(finish:
            {
                locationCall in
                
                for location in locationCall.alllocation
                {
                    let loc = Location(id: location.id, state: location.state, campus: location.campus, building: location.building)
                    self.locationList.append(loc)
                }
        })
        
        // Request rooms - retrieves rooms and campus'
        self.API.requestRooms(finish:
            {
                temprooms in
                
                for room in temprooms.allrooms
                {
                    let rom = Room(id: room.id, room: room.room, capacity: room.capacity)
                    self.roomList.append(rom)
                }
                
                for campus in temprooms.allcampus
                {
                    let camp = Campus(id: campus.id, campus: campus.campus)
                    self.campusList.append(camp)
                }
        })
        
        self.API.requestSkills(finish:
            {
                tempskills in
                
                for skill in tempskills.skills
                {
                    let skil = APISkill(id: skill.id, name: skill.name, score: skill.score)
                    self.skillList.append(skil)
                }
        })
        
        self.API.requestTrainers(finish:
            {
                temptrainer in
                
                for trainer in temptrainer.trainers
                {
                    let train = Trainer(id: trainer.id, name: trainer.name, email: trainer.email, location: trainer.location, picture: trainer.picture, skills: trainer.skills)
                    
                    self.trainerList.append(train)
                }
        })
        
        
        
        #warning("Need to finish/refactor the API to include the currently missing parameters before finishing this.")
        
//        self.API.requestBatches(finish:
//            {
//                tempbatches in
//
//                for batch in tempbatches.batchInfo
//                {
//                    let bat = Batch(name: batch.name, size: 0, skills: [Skill](), location: )
//                }
//        })
        
        
        
        print("End of request call...")
    }
    
    
    
    
    
    
    
    // MARK: Persistence Layer Methods
    /// Subsection 1: In memory -> SQLite Database
    
   
    
    // MARK: Persistence Layer Methods
    /// Subsection 2: SQLite Data -> Business Class (Application Layer)
    
    

    // MARK: Data Accessors
    /// Subsection 3: Retrieve references stored in this service class to populate UI elements/verify entities
    
    func verifyPreviousLogin() -> Bool
    {
        self.activeUser = self.userInfoBusinessService.getUserInfo()
        
        if activeUser != nil
        {
            return true
        }
        
        return false
    }
}
