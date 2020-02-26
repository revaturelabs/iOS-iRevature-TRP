//
//  BatchRoomDBOperations.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/25/20.
//  Copyright © 2020 admin. All rights reserved.
//

extension DatabaseOperations{
    
    func createBatchRoomTable(){
        
        if let batchRoomTable = iRevatureTables.batchRoomTable.makeStatement(){
            debugPrint(batchRoomTable)
        }
        
        //Tries to executes the SQLite3 Prepared Statement
        
        do{
            
            try database.createTable(table: iRevatureTables.batchRoomTable)
            
        } catch{
            
            debugPrint("Oops! a problem occurred with: trainer table")
            
        }
        
    }
    
    func insertBatchRoomRecord(batchID: Int, roomID: String){
        
        let insertStatement = InsertStatement(table: iRevatureTables.batchRoomTable, columnValues: batchID, roomID)
        
        do {
           
            try database.insertRow(statement: insertStatement)
            
        } catch {
            
            debugPrint("Insert did not work!")
            
        }
        
    }
    
    //Not the best approach, will replace with SQLite Library
    func selectAllBatchRoomRecords() -> [[String: Any]]{
       
        var selectStatement = SelectStatement()
        
        selectStatement.specifyColumn(table: iRevatureTables.batchRoomTable, columnName: "batch_id", asName: "batchID")
        
        selectStatement.specifyColumn(table: iRevatureTables.batchRoomTable, columnName: "room_id", asName: "roomID")
        
        do {
            
            let query = try (database.selectData(statement: selectStatement) ?? [["":""]])
            
           return query
            
            
        } catch {
            
            debugPrint("Opps! Something went wrong with User Select")
            
        }
        
        return [["":""]]
    }
}
