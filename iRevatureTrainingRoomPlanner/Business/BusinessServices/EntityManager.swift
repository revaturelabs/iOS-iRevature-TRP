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
    var campusList : [Campus]
    var skillList : [APISkill]
    //var batchList : [Batch]
    
    
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
    }
    
    
    func requestAllAPI()
    {
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
    }
    
    
    
    
    
    
    
    // MARK: Persistence Layer Methods
    /// Subsection 1: In memory -> SQLite Database
    
   
    
    // MARK: Persistence Layer Methods
    /// Subsection 2: SQLite Data -> Business Class (Application Layer)
    
    

    // MARK: Populate UI
    /// Subsection 3: Retrieve containers stored in this service class to populate UI elements
}
