//
//  CalendarDBOperations.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/23/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension DatabaseOperations{
    
    func createCalendarTable(){
        
        if let calendarTable = iRevatureTables.calendarTable.makeStatement(){
//            debugPrint(calendarTable)
        }
        
        //Tries to executes the SQLite3 Prepared Statement
        do{
            
            try database.createTable(table: iRevatureTables.calendarTable.self)
            
        } catch{
            
            debugPrint("Oops! a problem occurred with: trainer table")
            
        }
        
    }
    
    func insertCalendarRecord(calendarID: Int, startDate: String, endDate: String){
        
        let insertStatement = InsertStatement(table: iRevatureTables.calendarTable, columnValues: calendarID, startDate, endDate)
        
        do {
           
            try database.insertRow(statement: insertStatement)
            
        } catch {
            
            debugPrint("Insert did not work!")
            
        }
        
    }
    
    //Not the best approach, will replace with SQLite Library
    func selectAllCalendarRecords() -> [[String: Any]]{
       
        var selectStatement = SelectStatement()
        
        selectStatement.specifyColumn(table: iRevatureTables.calendarTable, columnName: "calendar_id", asName: "calendarID")
        
        selectStatement.specifyColumn(table: iRevatureTables.calendarTable, columnName: "start_date", asName: "startDate")
        
        selectStatement.specifyColumn(table: iRevatureTables.calendarTable, columnName: "end_date", asName: "endDate")
        
        do {
            
            let query = try (database.selectData(statement: selectStatement) ?? [["":""]])
            
           return query
            
            
        } catch {
            
            debugPrint("Opps! Something went wrong with User Select")
            
        }
        
        return [["":""]]
    }
}
