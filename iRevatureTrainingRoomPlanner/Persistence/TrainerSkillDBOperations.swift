//
//  TrainerSkillDBOperations.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/25/20.
//  Copyright © 2020 admin. All rights reserved.
//

extension DatabaseOperations{
    
    func createTrainerSkillTable(){
        
        if let trainerSkillTable = iRevatureTables.trainerSkillTable.makeStatement(){
            
//            debugPrint(trainerSkillTable)
            
        }
        
        //Tries to executes the SQLite3 Prepared Statement
        
        do{
            
            try database.createTable(table: iRevatureTables.trainerSkillTable)
            
        } catch{
            
            debugPrint("Oops! a problem occurred with: trainer table")
            
        }
        
    }
    
    func insertTrainerSkillRecord(trainerID: String, skillName: String){
        
        let insertStatement = InsertStatement(table: iRevatureTables.trainerSkillTable, columnValues: trainerID, skillName)
        
        do {
           
            try database.insertRow(statement: insertStatement)
            
        } catch {
            
            debugPrint("Skill insert did not work!")
            
        }
        
    }
    
    //Not the best approach, will replace with SQLite Library
    func selectAllTrainerSkillRecords() -> [[String: Any]]{
       
        var selectStatement = SelectStatement()
        
        selectStatement.specifyColumn(table: iRevatureTables.trainerSkillTable, columnName: "trainer_id", asName: "trainerID")
        
        selectStatement.specifyColumn(table: iRevatureTables.trainerSkillTable, columnName: "skill_name", asName: "skillName")
        
        do {
            
            let query = try (database.selectData(statement: selectStatement) ?? [["":""]])
            
           return query
            
            
        } catch {
            
            debugPrint("Opps! Something went wrong with User Select")
            
        }
        
        return [["":""]]
    }
}
