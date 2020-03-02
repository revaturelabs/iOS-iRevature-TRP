//
//  EntityManager.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by Jeremy Malisse on 2/19/20.
//  Modified by Jeremy Malisse on 3/2/2020
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
    /// Can possibly make this class as a singleton pattern. There should only ever be one and nothing should ever create it other than the reference in the App Delegate.
    
    // MARK: Application Entities/Containers
    
    private var activeUser : User?
    private var trainerList : [Trainer]
    private var roomList : [Room]
    private var locationList : [Location]
    private var campusList : [Campus]
    private var skillList : [Skill]
    //var batchList : [Batch]
    
    // MARK: User Defaults accessor class contained within this EM
    var userInfoBusinessService : UserInfoBusinessService = UserInfoBusinessService()
    
    // Initialization function - All necessary startup logic including populating containers
    init()
    {
        activeUser = nil
        trainerList = [Trainer]()
        roomList = [Room]()
        locationList = [Location]()
        campusList = [Campus]()
        skillList = [Skill]()
        initializePersistenceLayer()
        //batchList = [Batch]()
    }
    
    // Sets a class level reference to the Revature Mock API
    let API = RevatureAPI()
    
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
                // Otherwise, clear the reference to any existing data and don't save this data either.
                if(keepLoggedIn == true)
                {
                    self.userInfoBusinessService.setUserInfo(userObject: self.activeUser!)
                }
                else
                {
                    self.userInfoBusinessService.clearUserInfo()
                }
                
                // Either way call the completion handler which determines whether there will be a segue or not based on all verification so far
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
        
        // Request array of skills
        self.API.requestSkills(finish:
        {
                tempskills in
                
                for skill in tempskills.skills
                {
                    let skil = Skill(name: skill.name)
                    
                    self.skillList.append(skil)
                }
        })
        
        // Request all trainer data
        self.API.requestTrainers(finish:
        {
                temptrainer in
                
                for trainer in temptrainer.trainers
                {
                    let train = Trainer(id: trainer.id, name: trainer.name, emailaddress: trainer.emailaddress, primarylocation: trainer.primarylocation, profilepicture: trainer.profilepicture, manager_email: trainer.manager_email, skills: trainer.skills)
                    
                    self.trainerList.append(train)
                }
        })
        
        #warning("Batch API data was changed too close to submission. This struct requires refactoring to match the Entity to the JSON sent from the mock API.")
        
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
    
    
    // MARK: Persistence Layer Table Creation Methods :)
    func  initializePersistenceLayer(){
        
        DatabaseOperations.init().createAllTables()
        
    }
    
    
    // create tables
    //and verification for whether they exist
    
    // MARK: Persistence Layer Methods
    /// Subsection 1: In memory -> SQLite Database
    func insertTrainerToDatabase(){
        
        for trainer in self.trainerList{
           DatabaseOperations().insertTrainerRecord(trainerID: trainer.id, fullName: trainer.name, email: trainer.emailaddress, baseLocation: trainer.primarylocation, profilePicture: trainer.profilepicture ?? "")
            
            for skill in trainer.skills{
            DatabaseOperations().insertTrainerSkillRecord(trainerID: trainer.id, skillName: skill)
                
            }
            
        }
        
    }
    
    func insertRoomToDatabase(){
        
        for room in self.roomList{
            
            DatabaseOperations().insertRoomRecord(roomID: room.id, roomName: room.room, numberOfSeats: room.capacity)
            
        }
        
    }
    
    func insertLocationToDatabase(){
        
        for location in self.locationList{
            
            DatabaseOperations().insertLocationRecord(locationID: location.id, campus: location.campus, building: location.building, state: location.state)
            
        }
        
    }
    
    // insert tables
    
    // MARK: Persistence Layer Methods
    /// Subsection 2: SQLite Database -> In-memory
    
    func selectRoomFromDatabase() -> [Trainer]{
        
        var trainer: Trainer
        var trainers: [Trainer] = []
        var trainerDictionaryList = DatabaseOperations().selectAllTrainerRecords()
        
        for trainerFromDatabase in trainerDictionaryList{
            
            
            //Skills need to be added as an array
            trainer = Trainer(id: trainerFromDatabase["trainerID"]!, name: trainerFromDatabase["trainerFirstName"]!, emailaddress: trainerFromDatabase["email"]!, primarylocation: trainerFromDatabase[""]!, profilepicture: trainerFromDatabase[""]!
                , manager_email: trainerFromDatabase[""]!, skills: [trainerFromDatabase[""]!])
            
            trainers.append(trainer)
        }
        
        return trainers
    }
    
    
    
    // select statements
    
    
    // MARK: Data Accessors
    /// Subsection 3: Retrieve references stored in this service class to populate UI elements/verify entities
    
    // Checks whether a previous user has asked to remain logged into the system
    func verifyPreviousLogin() -> Bool
    {
        self.activeUser = self.userInfoBusinessService.getUserInfo()
        
        if activeUser != nil
        {
            return true
        }
        
        return false
    }
    
    // Returns the current saved user in the system, or will return nil if one does not exist
    /// Consider combining this the verifyPreviousLogin method to either return nil if no user exists or the User if one had been saved.
    func getActiveUser() -> User?
    {
        return self.activeUser
    }
    
    // MARK: Set of functions to get current in-memory containers of the following lists
    /// This data should be coming from the current persistence layer, but possibly only coming from the API at the moment
    func getTrainerList() -> [Trainer]
    {
        return self.trainerList
    }
    
    func getRoomList() -> [Room]
    {
        return self.roomList
    }
    
    func getLocationList() -> [Location]
    {
        return self.locationList
    }
    
    func getCampusList() -> [Campus]
    {
        return self.campusList
    }
    
    func getSkillList() -> [Skill]
    {
        return self.skillList
    }
}
