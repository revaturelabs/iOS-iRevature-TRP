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
    func selectUsers(){
    }
}
