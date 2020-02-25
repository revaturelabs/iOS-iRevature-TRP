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
            debugPrint(skillTable)
        }
        
        //Tries to executes the SQLite3 Prepared Statement
        
        do{
            
            try database.createTable(table: iRevatureTables.skillTable)
            
        } catch{
            
            debugPrint("Oops! a problem occurred with: trainer table")
            
        }
        
    }
    
    func insertSkillRecord(skillID: Int, skillName: String){
        
        let insertStatement = InsertStatement(table: iRevatureTables.calendarTable, columnValues: skillID, skillName)
        
        do {
           
            try database.insertRow(statement: insertStatement)
            
        } catch {
            
            debugPrint("Insert did not work!")
            
        }
        
    }
    
    //Not the best approach, will replace with SQLite Library
    func selectAllSkillRecords() -> [[String: Any]]{
       
        var selectStatement = SelectStatement()
        
        selectStatement.specifyColumn(table: iRevatureTables.userTable, columnName: "skill_id", asName: "skill_id")
        
        selectStatement.specifyColumn(table: iRevatureTables.userTable, columnName: "skill_name", asName: "skill_name")
        
        do {
            
            let query = try (database.selectData(statement: selectStatement) ?? [["":""]])
            
           return query
            
            
        } catch {
            
            debugPrint("Opps! Something went wrong with User Select")
            
        }
        
        return [["":""]]
    }
}
