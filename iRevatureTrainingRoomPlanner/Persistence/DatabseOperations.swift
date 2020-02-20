//
//  DatabseOperations.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/19/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct iRevatureTables{

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

class DatabaseOperations {
    
    func createDatabse(){
        
        let filePath = DatabaseAccess.getDatabaseFilePath(name: "iRevatureTrainingRoomsData", pathDirectory: .documentDirectory, domainMask: .userDomainMask)
               
        //Open database
        let db = DatabaseAccess.openDatabase(path: filePath, createIfDoesNotExist: true)!
            
        createUserTable(database: db)
        
        insertUserRecord(databse: db, userID: 1, firstName: "test", lastName: "tester", email: "test@revature.com", token: "token1", keepMeLoggedIn: true, roles: "tester")
        
        createRoomTable(database: db)
        
        createTrainerTable(database: db)
    }
    
    //Since SQLite Doesn't have boolean types
    func booleanToInteger(myBoolean: Bool) -> Int {
        
        let toInteger = myBoolean ? 1 : 0
        
        return toInteger
    }
    
    func integerToBoolean(myInteger: Int) -> Bool{
        
        let myBoolean = myInteger > 0 ? true : false
        
        return myBoolean
    }
        
    
    
}
