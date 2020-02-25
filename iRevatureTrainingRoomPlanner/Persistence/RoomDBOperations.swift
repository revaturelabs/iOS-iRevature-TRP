//
//  RoomDBOperations.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/23/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension DatabaseOperations{
    
    func createRoomTable(){
        
        if let roomTable = iRevatureTables.roomTable.makeStatement(){
            debugPrint(roomTable)
        }
        
        //Tries to executes the SQLite3 Prepared Statement
        do{
            
            try database.createTable(table: iRevatureTables.roomTable)
            
        } catch{
            
            debugPrint("Oops! a problem occurred with: trainer table")
            
        }
        
    }
    
    //Not the best approach, will replace with SQLite Library
    func selectAllRoomRecords() -> [[String: Any]]{
       
        var selectStatement = SelectStatement()
        
        selectStatement.specifyColumn(table: iRevatureTables.userTable, columnName: "room_id", asName: "room_id")
        
        selectStatement.specifyColumn(table: iRevatureTables.userTable, columnName: "room_name", asName: "room_name")
        
        selectStatement.specifyColumn(table: iRevatureTables.userTable, columnName: "number_of_seats", asName: "number_of_seats")
        
        do{
            
            let query = try (database.selectData(statement: selectStatement) ?? [["":""]])
            
           return query
            
            
        } catch {
            
            debugPrint("Opps! Something went wrong with User Select")
            
        }
        
        return [["":""]]
    }
    
    func insertRoomRecord(roomID: String, roomName: String, numberOfSeats: Int){
        
        let insertStatement = InsertStatement(table: iRevatureTables.roomTable, columnValues: roomID, roomName, numberOfSeats)
        
        do {
            
            try database.insertRow(statement: insertStatement)
            
        } catch {
            
            debugPrint("Insert did not work!")
            
        }
    }
    
//   func deleteRoomRecord(whereColumn: String, whereValue: String){
//
//        var deleteStatement = DeleteStatement(table: iRevatureTables.roomTable)
//
//        var whereStatement = WhereStatement()
//
//        whereStatement.addStatement(table: iRevatureTables.roomTable, columnName: whereValue, expression: .EQUALS, columnValue: whereValue)
//
//        deleteStatement.setWhereStatement(statement: whereStatement)
//
//        do{
//
//            try database.deleteRow(statement: deleteStatement)
//
//            debugPrint("Delete Successful")
//
//        } catch {
//
//            debugPrint("Opps! Delete not successful")
//
//        }
//    }
//
//    func updateRoomRecord(column: String, value: String,whereColumn: String, whereValue: String){
//
//        var  updateStatement = UpdateStatement(table: iRevatureTables.userTable)
//
//        var whereStatement = WhereStatement()
//
//        whereStatement.addStatement(table: iRevatureTables.userTable, columnName: whereValue, expression: .EQUALS, columnValue: whereValue)
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

