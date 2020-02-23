//
//  TrainerDBOperations.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/21/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension DatabaseOperations{
    
    func createTrainerTable(){
        
        //Grabs a new instance of usertables based on iRevatureTables struct
        if let trainerTable = iRevatureTables.trainerTable.makeStatement(){
            debugPrint(trainerTable)
        }
        
        //Tries to executes the SQLite3 Prepared Statement
        do{
            
            try database.createTable(table: iRevatureTables.trainerTable.self)
            
        } catch{
            
            debugPrint("Oops! a problem occurred with: trainer table")
            
        }
        
    }
    
    func insertTrainerRecord(trainerID: String, firstName: String, lastName: String, email: String, phoneNumber: String, baseLocation: String, slackUsername: String){
        
        let insertStatement = InsertStatement(table: iRevatureTables.trainerTable, columnValues: trainerID, firstName, lastName, email, phoneNumber, baseLocation, slackUsername)
        
        do {
            
            try database.insertRow(statement: insertStatement)
            
        } catch {
            
            debugPrint("Insert did not work!")
            
        }
    }
}
