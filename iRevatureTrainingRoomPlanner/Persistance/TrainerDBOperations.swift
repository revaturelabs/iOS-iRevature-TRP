//
//  TrainerDBQueries.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/19/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension DatabaseOperations {
    
    func createTrainerTable(database: DatabaseAccess){
        
        //Creates an instance of a table 'user'
        var trainerTable = SQLiteTable(tableName: "trainer")
        
        //Adds columns to the instance of table 'user'
        trainerTable.addColumn(columnName: "trainer_id", dataType: .INT, constraints: .PRIMARYKEY, .NOTNULL)
        
        trainerTable.addColumn(columnName: "first_name", dataType: .CHAR, constraints: .NOTNULL)
        
        trainerTable.addColumn(columnName: "last_name", dataType: .CHAR, constraints: .NOTNULL)
        
        trainerTable.addColumn(columnName: "email", dataType: .CHAR, constraints: .NOTNULL, .UNIQUE)
        
        trainerTable.addColumn(columnName: "phone_number", dataType: .CHAR, constraints: .NOTNULL)
        
        trainerTable.addColumn(columnName: "base_location", dataType: .CHAR, constraints: .none)
        
        trainerTable.addColumn(columnName: "slack_user_name", dataType: .CHAR, constraints: .UNIQUE)
        
        //Builds 'user' table and its columns into a SQLite3 Statment
        if let trainerTable = trainerTable.makeStatement(){
            
            debugPrint(trainerTable)
            
        }
        
        //Execute the SQLite3 prepared statement
        do {
            
            try database.createTable(table: trainerTable.self)
            
        } catch  {
            
            debugPrint(database)
        }
        
    }
}
