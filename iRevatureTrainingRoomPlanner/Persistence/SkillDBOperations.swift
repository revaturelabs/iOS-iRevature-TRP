//
//  SkillDBOperations.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/23/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension DatabaseOperations{
    
    func createSkillTable(){
        
        if let skillTable = iRevatureTables.skillTable.makeStatement(){
//            debugPrint(skillTable)
        }
        
        //Tries to executes the SQLite3 Prepared Statement
        
        do{
            
            try database.createTable(table: iRevatureTables.skillTable)
            
        } catch{
            
            debugPrint("Oops! a problem occurred with: trainer table")
            
        }
        
    }
    
    func insertSkillRecord(skillName: String){
        
        let insertStatement = InsertStatement(table: iRevatureTables.skillTable, columnValues: skillName)
        
        do {
           
            try database.insertRow(statement: insertStatement)
            
        } catch {
            
            debugPrint("Skill insert did not work!")
            
        }
        
    }
    
    //Not the best approach, will replace with SQLite Library
    func selectAllSkillRecords() -> [[String: Any]]{
       
        var selectStatement = SelectStatement()
        
        selectStatement.specifyColumn(table: iRevatureTables.skillTable, columnName: "skill_id", asName: "skillID")
        
        selectStatement.specifyColumn(table: iRevatureTables.skillTable, columnName: "skill_name", asName: "skillName")
        
        do {
            
            let query = try (database.selectData(statement: selectStatement) ?? [["":""]])
            
           return query
            
            
        } catch {
            
            debugPrint("Opps! Something went wrong with User Select")
            
        }
        
        return [["":""]]
    }
}
