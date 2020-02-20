//
//  UserQueries.swift
//  iRevatureTrainingRoomPlanner
//
//  Created by admin on 2/19/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import SQLite3

//struct UserTable: SQLTable{
//
//    static var columns: [Self.columnNameString : Column]{
//        return["user_id" : Column(dataType: .INT, constraints: .none)]
//    }
//
//}

extension LoginViewController{
    
    //Statement Builder
    func prepareStatement(sql: String) throws -> OpaquePointer? {
        
        let filePath = DatabaseAccess.getDatabaseFilePath(name: "WesDatabase", pathDirectory: .documentDirectory, domainMask: .userDomainMask)
        
        let db = DatabaseAccess.openDatabase(path: filePath, createIfDoesNotExist: true)
        
        var statement: OpaquePointer?
        
        guard sqlite3_prepare_v2(db?.getDBPointer(), sql, -1, &statement, nil)
            == SQLITE_OK else {
                return nil
        }
        
        return statement
    }

    //SELECT * USERS
    func selectUsers() -> User?{
        
        let querySql = "SELECT * FROM user;"
        
        guard let queryStatement = try? prepareStatement(sql: querySql) else {
            
            return nil
            
        }
        
        defer {
            sqlite3_finalize(queryStatement)
        }
        
        //set the id to the parameter
//        guard sqlite3_bind_text(queryStatement, 1, trainerName, Int32(trainerName.count), nil) == SQLITE_OK else {
//            return nil
//        }
        
        guard sqlite3_step(queryStatement) == SQLITE_ROW else {
            return nil
        }
        
        
//        self.recordCount = 1
        
        //get the id column
        let id = sqlite3_column_int(queryStatement, 0)
        
        guard let queryResultCol1 =
            sqlite3_column_text(queryStatement, 1) else {
            
            debugPrint("Query result is nil.")
            
            return nil
        }
        
        //get the name column
        let name = String(cString: queryResultCol1) as NSString
        
        guard let queryResultCol2 =
            sqlite3_column_text(queryStatement, 2) else {
            
            print("Query result is nil.")
          
            return nil
        }
        
        //get the trainer column
        let trainer = String(cString: queryResultCol2) as NSString
        
        guard let queryResultCol3 =
            
            sqlite3_column_text(queryStatement, 3) else {
            
            return nil
        }
        
        //get the location column
        let location = String(cString: queryResultCol3) as NSString
        
        return User(firstName: "", lastName: "", email: "", token: "", keepLoggedIn: false)
    }
}
