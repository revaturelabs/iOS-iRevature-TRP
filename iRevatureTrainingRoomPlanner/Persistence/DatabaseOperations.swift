//
//  DatabaseOperations.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by Jeremy Malisse on 2/21/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct iRevatureTables {
    
    static var userTable: SQLiteTable {
        
        var userTable = SQLiteTable(tableName: "user")
        
        //Adds columns to the instance of table 'user'
        userTable.addColumn(columnName: "user_id", dataType: .CHAR, constraints: .PRIMARYKEY, .NOTNULL)
        
        userTable.addColumn(columnName: "first_name", dataType: .CHAR, constraints: .NOTNULL)
        
        userTable.addColumn(columnName: "last_name", dataType: .CHAR, constraints: .NOTNULL)
        
        userTable.addColumn(columnName: "email", dataType: .CHAR, constraints: .NOTNULL)
            
        userTable.addColumn(columnName: "user_role", dataType: .CHAR, constraints: .NOTNULL)
        
        userTable.addColumn(columnName: "token", dataType: .CHAR, constraints: nil)
        
        userTable.addColumn(columnName: "keep_logged_in", dataType: .BOOL, constraints: nil)
        
        return userTable
        
    }
    
    
    static var trainerTable: SQLiteTable {
        
        var userTable = SQLiteTable(tableName: "trainer")
        
        //Adds columns to the instance of table 'trainer'
        //Some contrainsts have been left blank for flexibility
        userTable.addColumn(columnName: "trainer_id", dataType: .CHAR, constraints: .PRIMARYKEY, .NOTNULL)
        
        userTable.addColumn(columnName: "first_name", dataType: .CHAR, constraints: .NOTNULL)
        
        userTable.addColumn(columnName: "last_name", dataType: .CHAR, constraints: .NOTNULL)
        
        userTable.addColumn(columnName: "email", dataType: .CHAR, constraints: nil)
                
        userTable.addColumn(columnName: "phone_number", dataType: .CHAR, constraints: nil)
        
        userTable.addColumn(columnName: "base_location", dataType: .CHAR, constraints: nil)
        
        userTable.addColumn(columnName: "slack_username", dataType: .CHAR, constraints: nil)
        
        return userTable
        
    }
    
}

class DatabaseOperations{
    
    func openDatabse(){
        
        let filePath = DatabaseAccess.getDatabaseFilePath(name: "iRevatureTrainer", pathDirectory: .documentDirectory, domainMask: .userDomainMask)
        
        //Open Databse
        let db = DatabaseAccess.openDatabase(path: filePath, createIfDoesNotExist: true)
        
    }
    
}
