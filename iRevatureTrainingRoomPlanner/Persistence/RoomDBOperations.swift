//
//  RoomDBOperations.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/20/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension DatabaseOperations {
    
    func createRoomTable(database: DatabaseAccess){
        
        //Creates an instance of a table 'user'
        var roomTable = SQLiteTable(tableName: "room")
        
        //Adds columns to the instance of table 'user'
        roomTable.addColumn(columnName: "room_id", dataType: .INT, constraints: .PRIMARYKEY, .NOTNULL)
        
        roomTable.addColumn(columnName: "batch_id", dataType: .CHAR, constraints: .NOTNULL)
        
        roomTable.addColumn(columnName: "room_name", dataType: .CHAR, constraints: .NOTNULL)
        
        roomTable.addColumn(columnName: "room_capacity", dataType: .INT, constraints: .NOTNULL)
        
        roomTable.addColumn(columnName: "is_available", dataType: .INT, constraints: .NOTNULL)
        
        //Builds 'user' table and its columns into a SQLite3 Statment
        if let roomTable = roomTable.makeStatement(){
            
            debugPrint(roomTable)
            
        }
        
        //Execute the SQLite3 prepared statement
        do {
            
            try database.createTable(table: roomTable.self)
            
        } catch  {
            
            debugPrint(database)
        }
        
    }
}
