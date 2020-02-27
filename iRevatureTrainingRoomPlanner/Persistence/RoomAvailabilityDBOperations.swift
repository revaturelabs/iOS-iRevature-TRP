//
//  RoomAvailabilityDBOperations.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/25/20.
//  Copyright © 2020 admin. All rights reserved.
//

extension DatabaseOperations{
    
    func createRoomAvailabilityTable(){
        
        if let roomAvailabilityTable = iRevatureTables.roomAvailabilityTable.makeStatement(){
//            debugPrint(roomAvailabilityTable)
        }
        
        //Tries to executes the SQLite3 Prepared Statement
        
        do{
            
            try database.createTable(table: iRevatureTables.roomAvailabilityTable)
            
        } catch{
            
            debugPrint("Oops! a problem occurred with: trainer table")
            
        }
        
    }
    
    func insertRoomAvailabilityRecord(roomID: Int, calendarID: String){
        
        let insertStatement = InsertStatement(table: iRevatureTables.roomAvailabilityTable, columnValues: roomID, calendarID)
        
        do {
           
            try database.insertRow(statement: insertStatement)
            
        } catch {
            
            debugPrint("Insert did not work!")
            
        }
        
    }
    
    //Not the best approach, will replace with SQLite Library
    func selectAllRoomAvailabilityRecords() -> [[String: Any]]{
       
        var selectStatement = SelectStatement()
        
        selectStatement.specifyColumn(table: iRevatureTables.roomAvailabilityTable, columnName: "room_id", asName: "roomID")
        
        selectStatement.specifyColumn(table: iRevatureTables.roomAvailabilityTable, columnName: "calendar_id", asName: "calendarID")
        
        do {
            
            let query = try (database.selectData(statement: selectStatement) ?? [["":""]])
            
           return query
            
            
        } catch {
            
            debugPrint("Opps! Something went wrong with User Select")
            
        }
        
        return [["":""]]
    }
}
