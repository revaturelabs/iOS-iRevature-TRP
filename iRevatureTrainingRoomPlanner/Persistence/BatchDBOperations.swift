//
//  BatchDBOperations.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/23/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension DatabaseOperations{
    
    func createBatchTable(){
        
        if let batchTable = iRevatureTables.batchTable.makeStatement(){
            debugPrint(batchTable)
        }
        
        //Tries to executes the SQLite3 Prepared Statement
        do{
            
            try database.createTable(table: iRevatureTables.batchTable)
            
        } catch{
            
            debugPrint("Oops! a problem occurred with: trainer table")
            
        }
        
    }
    
    func insertBatchRecord(batchID: String, trainerID: String, roomID: String){
           
           let insertStatement = InsertStatement(table: iRevatureTables.batchTable, columnValues: batchID, trainerID, roomID)
           
           do {
              
               try database.insertRow(statement: insertStatement)
               
           } catch {
               
               debugPrint("Insert did not work!")
               
           }
           
       }
       
       //Not the best approach, will replace with SQLite Library
       func selectAllBatchRecords() -> [[String: Any]]{
          
           var selectStatement = SelectStatement()
           
           selectStatement.specifyColumn(table: iRevatureTables.userTable, columnName: "batch_id", asName: "batch_id")
           
           selectStatement.specifyColumn(table: iRevatureTables.userTable, columnName: "trainer_id", asName: "trainer_id")
           
           selectStatement.specifyColumn(table: iRevatureTables.userTable, columnName: "room_id", asName: "room_id")
           
           selectStatement.specifyColumn(table: iRevatureTables.userTable, columnName: "number_of_seats", asName: "number_of_seats")
           
           do{
               
               let query = try (database.selectData(statement: selectStatement) ?? [["":""]])
               
              return query
               
               
           } catch {
               
               debugPrint("Opps! Something went wrong with User Select")
               
           }
           
           return [["":""]]
       }
}
