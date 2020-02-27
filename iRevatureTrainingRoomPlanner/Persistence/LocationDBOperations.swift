//
//  LocationDBOperations.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/26/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension DatabaseOperations{
    
     func createLocationTable(){
            
            if let locationTable = iRevatureTables.locationTable.makeStatement() {
                
    //            debugPrint(trainerSkillTable)
                
            }
            
            //Tries to executes the SQLite3 Prepared Statement
            
            do{
                
                try database.createTable(table: iRevatureTables.locationTable)
                
            } catch{
                
                debugPrint("Oops! a problem occurred with: location table")
                
            }
            
        }
        
    func insertLocationRecord(locationID: String, campus: String, building: String, state: String) {
            
            let insertStatement = InsertStatement(table: iRevatureTables.locationTable, columnValues: locationID, campus, building, state)
            
            do {
               
                try database.insertRow(statement: insertStatement)
                
            } catch {
                
                debugPrint("Insert did not work!")
                
            }
            
        }
        
        //Not the best approach, will replace with SQLite Library
        func selectAllLocationRecords() -> [[String: Any]] {
           
            var selectStatement = SelectStatement()
            
            selectStatement.specifyColumn(table: iRevatureTables.locationTable, columnName: "location_id", asName: "locationID")
            
            selectStatement.specifyColumn(table: iRevatureTables.locationTable, columnName: "campus", asName: "campus")
            
            selectStatement.specifyColumn(table: iRevatureTables.locationTable, columnName: "building", asName: "building")
            
            selectStatement.specifyColumn(table: iRevatureTables.locationTable, columnName: "state", asName: "state")
            
            do {
                
                let query = try (database.selectData(statement: selectStatement) ?? [["":""]])
                
               return query
                
                
            } catch {
                
                debugPrint("Opps! Something went wrong with User Select")
                
            }
            
            return [["":""]]
        }
}
