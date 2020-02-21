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
    userTable.addColumn(columnName: "user_id", dataType: .INT, constraints: .PRIMARYKEY, .NOTNULL)

    userTable.addColumn(columnName: "first_name", dataType: .CHAR, constraints: .NOTNULL)

    userTable.addColumn(columnName: "last_name", dataType: .CHAR, constraints: .NOTNULL)

    userTable.addColumn(columnName: "email", dataType: .CHAR, constraints: .NOTNULL)

    userTable.addColumn(columnName: "keep_logged_in", dataType: .INT, constraints: .none)

    userTable.addColumn(columnName: "token", dataType: .CHAR, constraints: .none)

    userTable.addColumn(columnName: "user_role", dataType: .CHAR, constraints: .NOTNULL)

    return userTable
    
    }
    
}

class DatanseOperations{
        
    func openDatabse(){
        
        let filePath = DatabaseAccess.getDatabaseFilePath(name: "iRevatureTrainer", pathDirectory: .documentDirectory, domainMask: .userDomainMask)
        
        //Open Databse
        let db = DatabaseAccess.openDatabase(path: filePath, createIfDoesNotExist: true)
        
    }
    
}
