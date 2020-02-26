//
//  BatchSkillDBOperations.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/25/20.
//  Copyright © 2020 admin. All rights reserved.
//

extension DatabaseOperations{
    
    func createBatchSkillTable(){
        
        if let batchSkillTable = iRevatureTables.batchSkillTable.makeStatement(){
            debugPrint(batchSkillTable)
        }
        
        //Tries to executes the SQLite3 Prepared Statement
        
        do{
            
            try database.createTable(table: iRevatureTables.batchSkillTable)
            
        } catch{
            
            debugPrint("Oops! a problem occurred with: trainer table")
            
        }
        
    }
    
    func insertBatchSkillRecord(batchID: Int, skillID: String){
        
        let insertStatement = InsertStatement(table: iRevatureTables.batchSkillTable, columnValues: batchID, skillID)
        
        do {
           
            try database.insertRow(statement: insertStatement)
            
        } catch {
            
            debugPrint("Insert did not work!")
            
        }
        
    }
    
    //Not the best approach, will replace with SQLite Library
    func selectAllBatchSkillRecords() -> [[String: Any]]{
       
        var selectStatement = SelectStatement()
        
        selectStatement.specifyColumn(table: iRevatureTables.batchSkillTable, columnName: "batch_id", asName: "batchID")
        
        selectStatement.specifyColumn(table: iRevatureTables.batchSkillTable, columnName: "skill_id", asName: "skillID")
        
        do {
            
            let query = try (database.selectData(statement: selectStatement) ?? [["":""]])
            
           return query
            
            
        } catch {
            
            debugPrint("Opps! Something went wrong with User Select")
            
        }
        
        return [["":""]]
    }
}
