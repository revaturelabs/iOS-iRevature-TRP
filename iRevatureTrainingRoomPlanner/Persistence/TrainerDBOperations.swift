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
        
        //Grabs a new instance of trainertables based on iRevatureTables struct
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
    
    //Not the best approach, will replace with SQLite Library
    func selectAllTrainerRecords() -> [[String: Any]]{
        
        var selectStatement = SelectStatement()
        
        selectStatement.specifyColumn(table: iRevatureTables.trainerTable, columnName: "trainer_id", asName: "trainerID")
        
        selectStatement.specifyColumn(table: iRevatureTables.trainerTable, columnName: "first_name", asName: "firstName")
        
        selectStatement.specifyColumn(table: iRevatureTables.trainerTable, columnName: "last_name", asName: "lastName")
        
        selectStatement.specifyColumn(table: iRevatureTables.trainerTable, columnName: "email", asName: "email")
        
        selectStatement.specifyColumn(table: iRevatureTables.trainerTable, columnName: "phone_number", asName: "phoneNumber")
        
        selectStatement.specifyColumn(table: iRevatureTables.trainerTable, columnName: "base_location", asName: "baseLocation")
        
        selectStatement.specifyColumn(table: iRevatureTables.trainerTable, columnName: "slack_username", asName: "slackUsername")
        
        do{
            
            let query = try (database.selectData(statement: selectStatement) ?? [["":""]])
            
            return query
            
            
        } catch {
            
            debugPrint("Opps! Something went wrong with User Select")
            
        }
        
        return [["":""]]
    }
    
    func insertTrainerRecord(trainerID: String, firstName: String, lastName: String, email: String, phoneNumber: String, baseLocation: String, slackUsername: String){
        
        let insertStatement = InsertStatement(table: iRevatureTables.trainerTable, columnValues: trainerID, firstName, lastName, email, phoneNumber, baseLocation, slackUsername)
        
        do {
            
            try database.insertRow(statement: insertStatement)
            
        } catch {
            
            debugPrint("Insert did not work!")
            
        }
    }
//
//    func deleteTrainerRecord(){
//
//        var deleteStatement = DeleteStatement(table: iRevatureTables.trainerTable)
//
//        var whereStatement = WhereStatement()
//
//        whereStatement.addStatement(table: iRevatureTables.trainerTable, columnName: "trainer_id", expression: .EQUALS, columnValue: "Trainer_01")
//
//        deleteStatement.setWhereStatement(statement: whereStatement)
//
//        do{
//            try database.deleteRow(statement: deleteStatement)
//            debugPrint("Delete Successful")
//        } catch {
//            debugPrint("Opps! Delete not successful")
//        }
//    }
//
//    func updateTrainerRecord(column: String, value: String,whereColumn: String, whereValue: String){
//
//        var  updateStatement = UpdateStatement(table: iRevatureTables.trainerTable)
//
//        var whereStatement = WhereStatement()
//
//        whereStatement.addStatement(table: iRevatureTables.trainerTable, columnName: whereValue, expression: .EQUALS, columnValue: whereValue)
//
//        updateStatement.addValueChange(columnToUpdate: column, updatedValue: value)
//
//        updateStatement.setWhereStatement(statement: whereStatement)
//
//        do{
//
//            try database.updateRow(statement: updateStatement)
//
//        } catch {
//
//        }
//
//    }
}
