//
//  UserDBOperations.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/21/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension DatabaseOperations{
    
    func createUserTable(){
        
        //Grabs a new instance of usertables based on iRevatureTables struct
        if let userTable = iRevatureTables.userTable.makeStatement(){
            debugPrint(userTable)
        }
        
        //Tries to executes the SQLite3 Prepared Statement
        do{
            
            try databse.createTable(table: iRevatureTables.userTable.self)
            
        } catch{
            
            debugPrint("Oops! a problem occurred with: usertable")
            
        }
        
    }
    
    func insertUserRecord(userID: String, firstName: String, lastName: String, email: String, token: String, userRole: String, keepMeLoggedIn: Bool){
        
        let insertStatement = InsertStatement(table: iRevatureTables.userTable, columnValues: userID, firstName, lastName, email, token, userRole, keepMeLoggedIn)
        
        do {
           
            try databse.insertRow(statement: insertStatement)
            
        } catch {
            
            debugPrint("Insert did not work!")
            
        }
        
    }
    
}
